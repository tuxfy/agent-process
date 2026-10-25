#!/bin/sh
# Setzt die Regeln beim Hoster aus der Checkliste in Stufe 0, soweit sie fehlen.
# GitHub über gh, GitLab über glab — angemeldet, mit Admin- bzw. Maintainer-Rechten.
# Andere Hoster: Checkliste in _agent-process/anweisungen/00-einrichtung.md.
# Vorhandene Regeln bleiben unverändert; einzige Ausnahme: ein Schutz des Haupt-Branches,
# der Push erlaubt, wird verschärft. Wird von `init.sh --hoster` aufgerufen.
# Läuft mit deinen Rechten auf deinem Rechner, nicht im Agent-Container: dessen Token hat
# bewusst keine Admin-Rechte, dort meldet das Skript nur, was fehlt.
# Erst nach dem ersten Push sinnvoll (vorher ist das Repo beim Hoster leer).
# GitHub: Rulesets main-schutz (nur PR, nur Merge-Commit, kein Force-Push, nicht löschbar),
#   next-schutz, tag-schutz (v*). Optional CI_PRUEFUNG=<Name des CI-Jobs>: CI-Prüfung für main als Pflicht.
#   Repo-Einstellung: automatisches Zusammenführen erlaubt (bei jedem Lauf gesetzt).
#   Im kostenlosen Plan setzt GitHub Regeln nur in öffentlichen Repos durch.
# GitLab: geschützte Branches main (Push niemand) und next (Push Developer), geschützte Tags v*,
#   Merge-Commits und „nur bei erfolgreicher Pipeline“ (Projekt-Einstellung, bei jedem Lauf gesetzt); Squash bleibt wählbar — Release-MR
#   nach main von Hand ohne Squash.
# Branches nach dem Zusammenführen löschen und Auslieferung für Tags freigeben: Handgriffe laut Checkliste.

set -eu

hinweis(){ echo "Hinweis:  Hoster: $1"; }
leer()   { hinweis "Repo noch leer — erst den ersten Commit pushen, dann sh _agent-process/init.sh --hoster erneut ausführen"; }

# ---------- GitHub ----------
github() {
  [ -z "$(gh api "repos/$R/branches" --jq '.[].name' 2>/dev/null)" ] && { leer; return; }
  vorhanden=$(gh api "repos/$R/rulesets" --jq '.[].name' 2>/dev/null || true)

  regel() { # $1 Name, $2 JSON
    if echo "$vorhanden" | grep -qxF "$1"; then
      echo "vorhanden: Regel $1 (unverändert)"
    elif echo "$2" | gh api -X POST "repos/$R/rulesets" --input - >/dev/null 2>&1; then
      echo "angelegt: Regel $1"
    else
      hinweis "Regel $1 nicht angelegt (Rechte? Plan?) — von Hand nach Checkliste Stufe 0"
    fi
  }

  pruefung=""
  if [ -n "${CI_PRUEFUNG:-}" ]; then
    pruefung=",{\"type\":\"required_status_checks\",\"parameters\":{\"strict_required_status_checks_policy\":false,\"required_status_checks\":[{\"context\":\"$CI_PRUEFUNG\"}]}}"
  fi

  regel main-schutz "{\"name\":\"main-schutz\",\"target\":\"branch\",\"enforcement\":\"active\",
   \"conditions\":{\"ref_name\":{\"include\":[\"~DEFAULT_BRANCH\"],\"exclude\":[]}},
   \"rules\":[{\"type\":\"deletion\"},{\"type\":\"non_fast_forward\"},
    {\"type\":\"pull_request\",\"parameters\":{\"required_approving_review_count\":0,\"dismiss_stale_reviews_on_push\":false,\"require_code_owner_review\":false,\"require_last_push_approval\":false,\"required_review_thread_resolution\":false,\"allowed_merge_methods\":[\"merge\"]}}$pruefung]}"

  regel next-schutz '{"name":"next-schutz","target":"branch","enforcement":"active",
   "conditions":{"ref_name":{"include":["refs/heads/next"],"exclude":[]}},
   "rules":[{"type":"deletion"},{"type":"non_fast_forward"}]}'

  regel tag-schutz '{"name":"tag-schutz","target":"tag","enforcement":"active",
   "conditions":{"ref_name":{"include":["refs/tags/v*"],"exclude":[]}},
   "rules":[{"type":"deletion"},{"type":"update"}]}'

  if [ -z "${CI_PRUEFUNG:-}" ] && ! echo "$vorhanden" | grep -qxF main-schutz; then
    hinweis "CI-Prüfung für main nicht als Pflicht gesetzt — in main-schutz ergänzen oder vorher mit CI_PRUEFUNG=<Job> aufrufen"
  fi

  if gh api -X PATCH "repos/$R" -F allow_auto_merge=true >/dev/null 2>&1; then
    echo "gesetzt:  automatisches Zusammenführen erlaubt"
  else
    hinweis "Repo-Einstellungen nicht gesetzt — von Hand nach Checkliste Stufe 0"
  fi
}

# ---------- GitLab ----------
gitlab() {
  glab api "projects/:id/repository/branches" 2>/dev/null | grep -q '"name"' || { leer; return; }
  haupt=$(glab api "projects/:id" 2>/dev/null | sed -n 's/.*"default_branch": *"\([^"]*\)".*/\1/p' | head -1)
  [ -n "$haupt" ] || haupt=main
  geschuetzt=$(glab api "projects/:id/protected_branches" 2>/dev/null || true)

  anlegen() { # $1 Branch, $2 Push-Recht (0 niemand, 30 Developer)
    glab api -X POST "projects/:id/protected_branches" -f name="$1" -F push_access_level="$2" \
      -F merge_access_level=40 -F allow_force_push=false >/dev/null 2>&1
  }
  # Push oder Force-Push auf dem Haupt-Branch erlaubt? (GitLab schützt ihn oft selbst, mit Push für Maintainer)
  zu_schwach() {
    flach=$(glab api "projects/:id/protected_branches/$(echo "$1" | sed 's|/|%2F|g')" 2>/dev/null | tr -d ' \n')
    echo "$flach" | grep -q '"allow_force_push":true' && return 0
    echo "$flach" | sed -n 's/.*"push_access_levels":\[\([^]]*\)\].*/\1/p' | grep -Eq '"access_level":[1-9]|"user_id":[0-9]|"group_id":[0-9]|"deploy_key_id":[0-9]'
  }
  branch() { # $1 Branch, $2 Push-Recht, $3 Text, $4 "streng" = zu schwachen Schutz verschärfen
    if ! echo "$geschuetzt" | grep -Eq "\"name\": *\"$1\""; then
      if anlegen "$1" "$2"; then echo "angelegt: Schutz $1 ($3)"
      else hinweis "Schutz $1 nicht angelegt (Rechte?) — von Hand nach Checkliste Stufe 0"; fi
    elif [ "${4:-}" = streng ] && zu_schwach "$1"; then
      if glab api -X DELETE "projects/:id/protected_branches/$(echo "$1" | sed 's|/|%2F|g')" >/dev/null 2>&1 \
         && anlegen "$1" "$2"; then
        echo "verschärft: Schutz $1 (vorher Push erlaubt) → $3"
      else
        hinweis "Schutz $1 erlaubt Push — von Hand verschärfen: $3"
      fi
    else
      echo "vorhanden: Schutz $1 (unverändert)"
    fi
  }
  branch "$haupt" 0  "Push niemand, Merge Maintainer, kein Force-Push" streng
  branch next     30 "Push Developer, Merge Maintainer, kein Force-Push"

  if glab api "projects/:id/protected_tags" 2>/dev/null | grep -Eq '"name": *"v\*"'; then
    echo "vorhanden: Schutz Tags v* (unverändert)"
  elif glab api -X POST "projects/:id/protected_tags" -f name='v*' -F create_access_level=40 >/dev/null 2>&1; then
    echo "angelegt: Schutz Tags v* (anlegen nur Maintainer)"
  else
    hinweis "Schutz Tags v* nicht angelegt (Rechte?) — von Hand nach Checkliste Stufe 0"
  fi

  if glab api -X PUT "projects/:id" -f merge_method=merge -F only_allow_merge_if_pipeline_succeeds=true >/dev/null 2>&1; then
    echo "gesetzt:  Merge-Commits, Zusammenführen nur bei erfolgreicher Pipeline"
    hinweis "Squash bleibt wählbar — Release-MR nach $haupt von Hand als Merge-Commit ohne Squash"
  else
    hinweis "Projekt-Einstellungen nicht gesetzt — von Hand nach Checkliste Stufe 0"
  fi
}

# ---------- Hoster erkennen ----------
if command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1 \
   && R=$(gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null); then
  github
elif command -v glab >/dev/null 2>&1 && glab api "projects/:id" >/dev/null 2>&1; then
  gitlab
else
  hinweis "weder gh noch glab angemeldet oder kein Repo beim Hoster — Regeln nicht gesetzt; nach dem ersten Push sh _agent-process/init.sh --hoster erneut ausführen oder Checkliste Stufe 0"
  exit 0
fi
hinweis "Handgriffe laut Checkliste Stufe 0: Auslieferung für Tags v* freigeben; Branches nach dem Zusammenführen löschen erst, wenn next nachweislich geschützt ist"
exit 0
