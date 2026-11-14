#!/bin/sh
# Legt im Projekt an, was aus dem Prozess-Repo fehlt. Überschreibt nie Dateien; entfernt nur eigene tote ap-Skill-Links.
# Aufruf im Projekt-Hauptordner: sh _agent-process/init.sh [--hoster]
# --hoster: setzt zusätzlich die Regeln beim Hoster (init/hoster-schutz.sh, mit deinen Rechten).

set -eu

case "${1:-}" in
  ""|--hoster) ;;
  *) echo "Fehler: unbekannte Option '$1'. Aufruf: sh _agent-process/init.sh [--hoster]" >&2; exit 2;;
esac

P=_agent-process
SRC="$P/init"

if [ ! -f "$P/AGENTS.md" ] || [ ! -d "$SRC" ]; then
  echo "Fehler: im Projekt-Hauptordner ausführen (dort, wo $P/ liegt)." >&2
  exit 1
fi

angelegt=0
entfernt=0
hinweise=0
neu()    { echo "angelegt: $1"; angelegt=$((angelegt + 1)); }
weg()    { echo "entfernt: $1"; entfernt=$((entfernt + 1)); }
hinweis(){ echo "Hinweis:  $1"; hinweise=$((hinweise + 1)); }

# Datei kopieren, wenn sie fehlt
kopiere() {
  if [ -e "$2" ]; then return 1; fi
  mkdir -p "$(dirname "$2")"
  cp "$1" "$2"
  neu "$2"
}

# AGENTS.md
if ! kopiere "$SRC/AGENTS.md" AGENTS.md; then
  grep -q "$P/AGENTS.md" AGENTS.md || hinweis "AGENTS.md verweist nicht auf $P/AGENTS.md (Vorlage: $SRC/AGENTS.md)"
fi

# CLAUDE.md
if ! kopiere "$SRC/CLAUDE.md" CLAUDE.md; then
  while IFS= read -r zeile; do
    grep -qxF "$zeile" CLAUDE.md || hinweis "CLAUDE.md: Zeile fehlt: $zeile"
  done < "$SRC/CLAUDE.md"
fi

# .claude/agents als Link
if [ -L .claude/agents ]; then
  :
elif [ -e .claude/agents ]; then
  hinweis ".claude/agents ist ein Ordner, kein Link auf ../$P/.claude/agents"
else
  mkdir -p .claude
  ln -s "../$P/.claude/agents" .claude/agents
  neu ".claude/agents -> ../$P/.claude/agents"
fi

# .claude/skills: je Skill ein Link; Init verwaltet nur Einträge mit Präfix ap-, eigene Skills bleiben
if [ -L .claude/skills ]; then
  hinweis ".claude/skills ist ein Link, kein Ordner; Skill-Links nicht angelegt"
else
  for s in "$P"/skills/ap-*; do
    [ -d "$s" ] || continue
    n=$(basename "$s")
    z=".claude/skills/$n"
    if [ -L "$z" ]; then
      [ "$(readlink "$z")" = "../../$s" ] || hinweis "$z zeigt nicht auf ../../$s"
    elif [ -e "$z" ]; then
      hinweis "$z ist ein Ordner, kein Link auf ../../$s"
    else
      mkdir -p .claude/skills
      ln -s "../../$s" "$z"
      neu "$z -> ../../$s"
    fi
  done
  for z in .claude/skills/ap-*; do
    [ -L "$z" ] && [ ! -e "$z" ] || continue
    [ "$(readlink "$z")" = "../../$P/skills/$(basename "$z")" ] || continue
    rm "$z"
    weg "$z (Skill gibt es nicht mehr)"
  done
fi

# _context/
for f in "$SRC"/context/*; do
  kopiere "$f" "_context/$(basename "$f")" || true
done
grep -q '^## UI-Pfade' _context/projekt.md || \
  hinweis "_context/projekt.md hat keinen Abschnitt „## UI-Pfade“ (Vorlage: $SRC/context/projekt.md)"
grep -q '^## Anspruch' _context/projekt.md || \
  hinweis "_context/projekt.md hat keinen Abschnitt „## Anspruch“ — der Agent schlägt ihn bei der nächsten Klärung vor (Vorlage: $SRC/context/projekt.md)"

# Ordner für Anforderungen und Releases (.gitkeep, damit Git sie kennt)
for d in _requirements/done _releases; do
  if [ ! -d "$d" ]; then
    mkdir -p "$d"
    touch "$d/.gitkeep"
    neu "$d/"
  fi
done
kopiere "$SRC/requirements/deferred/README.md" _requirements/deferred/README.md || true

# Alter Backlog-Ordner: Ideen und Bugs sind jetzt Issues (Stufe 1)
if [ -d _requirements/backlog ]; then
  eintraege=$(find _requirements/backlog -type f ! -name .gitkeep | wc -l | tr -d ' ')
  if [ "$eintraege" -gt 0 ]; then
    hinweis "_requirements/backlog/ enthält noch $eintraege Eintrag/Einträge — je Eintrag ein Issue anlegen (Stufe 1), dann den Ordner entfernen"
  else
    hinweis "_requirements/backlog/ wird nicht mehr gebraucht (Ideen und Bugs sind Issues) — Ordner entfernen"
  fi
fi

# Prüf-Konfiguration der UI-Richtlinie
if ! kopiere "$SRC/pruefung/stylelint.json" .stylelintrc.json; then
  cmp -s "$SRC/pruefung/stylelint.json" .stylelintrc.json || \
    hinweis "neuer Stand der Prüf-Konfiguration verfügbar: $SRC/pruefung/stylelint.json weicht von .stylelintrc.json ab"
fi

# .gitignore: fehlende Zeilen ergänzen
touch .gitignore
while IFS= read -r zeile; do
  [ -z "$zeile" ] && continue
  if ! grep -qxF "$zeile" .gitignore; then
    # Zeilenumbruch am Ende sicherstellen
    if [ -s .gitignore ] && [ "$(tail -c 1 .gitignore)" != "" ]; then echo >> .gitignore; fi
    echo "$zeile" >> .gitignore
    neu ".gitignore: $zeile"
  fi
done < "$SRC/gitignore"

# Regeln beim Hoster (Schutz von main, release-candidate, Tags) nur auf ausdrücklichen Aufruf
if [ "${1:-}" = --hoster ]; then
  sh "$SRC/hoster-schutz.sh" || hinweis "Regeln beim Hoster: Skript fehlgeschlagen (Checkliste Stufe 0)"
else
  echo "Regeln beim Hoster: nicht geprüft (bei Bedarf: sh $P/init.sh --hoster)"
fi

echo
echo "Fertig: $angelegt angelegt, $entfernt entfernt, $hinweise Hinweis(e). Keine Datei wurde überschrieben."
[ $((angelegt + entfernt)) -gt 0 ] && echo "Änderungen prüfen und committen."
exit 0
