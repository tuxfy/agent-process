#!/bin/sh
# Testet init/hoster-schutz.sh an einem Wegwerf-Repo beim Hoster und löscht es danach.
# Aufruf: sh test/hoster-schutz-test.sh github|gitlab [--behalten]
# Voraussetzung: gh bzw. glab angemeldet; für GitHub zum Löschen: gh auth refresh -s delete_repo

set -u

HOSTER=${1:-}
BEHALTEN=${2:-}
SKRIPT="$(cd "$(dirname "$0")/.." && pwd)/init/hoster-schutz.sh"
NAME="schutz-test-$(date +%Y%m%d%H%M%S)"
F=0

ok()     { echo "OK      $1"; }
fehler() { echo "FEHLER  $1"; F=$((F + 1)); }
soll_gehen()    { d=$1; shift; if "$@" >/dev/null 2>&1; then ok "$d"; else fehler "$d (abgelehnt)"; fi; }
soll_scheitern(){ d=$1; shift; if "$@" >/dev/null 2>&1; then fehler "$d (ging durch)"; else ok "$d (abgelehnt)"; fi; }
enthaelt()      { d=$1; muster=$2; if echo "$AUSGABE" | grep -q "$muster"; then ok "$d"; else fehler "$d"; fi; }
enthaelt_nicht(){ d=$1; muster=$2; if echo "$AUSGABE" | grep -q "$muster"; then fehler "$d"; else ok "$d"; fi; }
feld()          { echo "$1" | sed -n "s/.*\"$2\": *\"*\([^\",}]*\).*/\1/p" | head -1; }

case "$HOSTER" in github|gitlab) ;; *) echo "Aufruf: sh $0 github|gitlab [--behalten]" >&2; exit 2;; esac
[ -f "$SKRIPT" ] || { echo "Skript fehlt: $SKRIPT" >&2; exit 2; }

ARBEIT=$(mktemp -d)
cd "$ARBEIT" || exit 2
git init -q -b main
echo "== Wegwerf-Repo $NAME anlegen ($HOSTER)"

if [ "$HOSTER" = github ]; then
  gh auth status >/dev/null 2>&1 || { echo "gh nicht angemeldet" >&2; exit 2; }
  gh repo create "$NAME" --public >/dev/null || exit 2
  if [ "$(gh config get git_protocol 2>/dev/null)" = ssh ]; then
    URL=$(gh repo view "$NAME" --json sshUrl -q .sshUrl)
  else
    URL="$(gh repo view "$NAME" --json url -q .url).git"
  fi
  R=$(gh repo view "$NAME" --json nameWithOwner -q .nameWithOwner)
else
  glab auth status >/dev/null 2>&1 || { echo "glab nicht angemeldet" >&2; exit 2; }
  ANTWORT=$(glab api -X POST projects -f name="$NAME" -f visibility=private) || exit 2
  R=$(feld "$ANTWORT" path_with_namespace)
  if [ "$(glab config get git_protocol 2>/dev/null)" = ssh ]; then
    URL=$(feld "$ANTWORT" ssh_url_to_repo)
  else
    URL=$(feld "$ANTWORT" http_url_to_repo)
  fi
fi
git remote add origin "$URL"
echo "   $R"

aufraeumen() {
  cd / || true
  if [ "$BEHALTEN" = --behalten ]; then
    echo "== Repo bleibt: $R"
  elif [ "$HOSTER" = github ]; then
    gh repo delete "$R" --yes >/dev/null 2>&1 && echo "== Repo gelöscht" || \
      echo "== Löschen fehlgeschlagen — gh auth refresh -s delete_repo, dann: gh repo delete $R --yes"
  else
    glab repo delete "$R" --yes >/dev/null 2>&1 && echo "== Repo gelöscht (GitLab löscht ggf. verzögert)" || \
      echo "== Löschen fehlgeschlagen — von Hand: glab repo delete $R --yes"
  fi
  rm -rf "$ARBEIT"
}
trap aufraeumen EXIT

echo "== 1. Lauf auf leerem Repo"
AUSGABE=$(sh "$SKRIPT"); echo "$AUSGABE" | sed 's/^/   /'
enthaelt "meldet leeres Repo" "Repo noch leer"
enthaelt_nicht "legt nichts an" "angelegt"

git commit -q --allow-empty -m "chore: start"
git push -q -u origin main 2>/dev/null || { fehler "erster Push nach main"; exit 1; }

echo "== 2. Lauf nach dem ersten Push"
AUSGABE=$(sh "$SKRIPT"); echo "$AUSGABE" | sed 's/^/   /'
enthaelt_nicht "keine Regel abgelehnt" "nicht angelegt"
enthaelt_nicht "Einstellungen gesetzt" "nicht gesetzt"

echo "== 3. Lauf erneut (darf nichts ändern)"
AUSGABE=$(sh "$SKRIPT"); echo "$AUSGABE" | sed 's/^/   /'
enthaelt_nicht "nichts neu angelegt" "^angelegt"
enthaelt "meldet Vorhandenes" "vorhanden"

echo "== 4. Regeln wirken"
git commit -q --allow-empty -m "test: direkt"
soll_scheitern "direkter Push nach main" git push origin main
git reset -q --hard origin/main

git tag v0.0.1
soll_gehen "Tag v0.0.1 anlegen" git push origin v0.0.1

git switch -q -c release-candidate
git commit -q --allow-empty -m "test: release-candidate"
soll_gehen "Push nach release-candidate" git push -u origin release-candidate
git commit -q --amend --allow-empty -m "test: release-candidate umgeschrieben"
soll_scheitern "Force-Push nach release-candidate" git push --force origin release-candidate
soll_scheitern "release-candidate löschen" git push origin --delete release-candidate

git tag -f v0.0.1 >/dev/null
soll_scheitern "Tag v0.0.1 verschieben" git push --force origin v0.0.1
soll_scheitern "Tag v0.0.1 löschen" git push origin --delete v0.0.1

echo "== 5. Einstellungen"
if [ "$HOSTER" = github ]; then
  git switch -q -c feature/test origin/main
  git commit -q --allow-empty -m "test: pr"
  git push -q -u origin feature/test 2>/dev/null
  gh pr create -R "$R" --base main --head feature/test --title "test: pr" --body "Test" >/dev/null 2>&1
  soll_scheitern "PR nach main per Squash" gh pr merge -R "$R" feature/test --squash
  soll_gehen "PR nach main als Merge-Commit" gh pr merge -R "$R" feature/test --merge
else
  P=$(glab api "projects/:id")
  [ "$(feld "$P" merge_method)" = merge ] && ok "nur Merge-Commits" || fehler "nur Merge-Commits"
  [ "$(feld "$P" only_allow_merge_if_pipeline_succeeds)" = true ] && ok "nur bei erfolgreicher Pipeline" || fehler "nur bei erfolgreicher Pipeline"
  echo "   (Zusammenführen selbst nicht getestet: ohne CI blockiert die Pipeline-Pflicht)"
fi

echo
[ "$F" -eq 0 ] && echo "Ergebnis: alles OK" || echo "Ergebnis: $F Fehler"
exit "$F"
