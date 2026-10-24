#!/bin/sh
# Legt im Projekt an, was aus dem Prozess-Repo fehlt. Überschreibt nie.
# Aufruf im Projekt-Hauptordner: sh _agent-process/init.sh

set -eu

P=_agent-process
SRC="$P/init"

if [ ! -f "$P/AGENTS.md" ] || [ ! -d "$SRC" ]; then
  echo "Fehler: im Projekt-Hauptordner ausführen (dort, wo $P/ liegt)." >&2
  exit 1
fi

angelegt=0
hinweise=0
neu()    { echo "angelegt: $1"; angelegt=$((angelegt + 1)); }
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

# _context/
for f in "$SRC"/context/*; do
  kopiere "$f" "_context/$(basename "$f")" || true
done

# Ordner für Anforderungen und Releases (.gitkeep, damit Git sie kennt)
for d in _requirements/backlog _requirements/done _releases; do
  if [ ! -d "$d" ]; then
    mkdir -p "$d"
    touch "$d/.gitkeep"
    neu "$d/"
  fi
done

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

echo
echo "Fertig: $angelegt angelegt, $hinweise Hinweis(e). Nichts wurde überschrieben."
[ "$angelegt" -gt 0 ] && echo "Änderungen prüfen und committen."
exit 0
