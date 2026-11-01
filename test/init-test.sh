#!/bin/sh
# Testet init.sh in einem Wegwerf-Ordner: Skill-Links, Aufräumen, Wiederholbarkeit.
# Aufruf: sh test/init-test.sh

set -u

REPO="$(cd "$(dirname "$0")/.." && pwd)"
F=0

ok()     { echo "OK      $1"; }
fehler() { echo "FEHLER  $1"; F=$((F + 1)); }
pruefe() { d=$1; shift; if "$@"; then ok "$d"; else fehler "$d"; fi; }
enthaelt()      { if echo "$AUSGABE" | grep -qF "$2"; then ok "$1"; else fehler "$1"; fi; }
enthaelt_nicht(){ if echo "$AUSGABE" | grep -qF "$2"; then fehler "$1"; else ok "$1"; fi; }

ARBEIT=$(mktemp -d)
trap 'rm -rf "$ARBEIT"' EXIT
cd "$ARBEIT" || exit 2
mkdir _agent-process
(cd "$REPO" && tar cf - --exclude=.git --exclude=.qa .) | (cd _agent-process && tar xf -)

mkdir -p .claude/skills/mein-skill
echo "eigen" > .claude/skills/mein-skill/SKILL.md
ln -s ../../nirgends .claude/skills/fremd
ln -s ../../_agent-process/skills/ap-entfallen .claude/skills/ap-entfallen
ln -s ../../woanders/ap-fremdziel .claude/skills/ap-fremdziel

echo "== Erster Lauf"
AUSGABE=$(sh _agent-process/init.sh 2>&1)
pruefe "Init endet ohne Fehler" [ $? -eq 0 ]
for s in _agent-process/skills/ap-*; do
  n=$(basename "$s")
  pruefe "Link $n" [ -L ".claude/skills/$n" ]
  pruefe "Link $n relativ" [ "$(readlink ".claude/skills/$n")" = "../../_agent-process/skills/$n" ]
  pruefe "Link $n führt zu SKILL.md" [ -f ".claude/skills/$n/SKILL.md" ]
done
pruefe "toter ap-Link entfernt" [ ! -L .claude/skills/ap-entfallen ]
enthaelt "Entfernen gemeldet" "entfernt: .claude/skills/ap-entfallen"
pruefe "eigener Skill bleibt" [ -f .claude/skills/mein-skill/SKILL.md ]
pruefe "toter Link ohne Präfix bleibt" [ -L .claude/skills/fremd ]
pruefe "deferred/README.md angelegt" [ -f _requirements/deferred/README.md ]
pruefe "toter ap-Link mit fremdem Ziel bleibt" [ -L .claude/skills/ap-fremdziel ]
enthaelt_nicht "fremdes Ziel nicht als entfernt gemeldet" "entfernt: .claude/skills/ap-fremdziel"

echo "== Zweiter Lauf"
echo "eigene Regeln" >> _requirements/deferred/README.md
AUSGABE=$(sh _agent-process/init.sh 2>&1)
enthaelt "nichts angelegt, nichts entfernt" "Fertig: 0 angelegt, 0 entfernt"
pruefe "deferred/README.md nicht überschrieben" grep -qx "eigene Regeln" _requirements/deferred/README.md
enthaelt_nicht "keine Meldung zu Skill-Links" ".claude/skills"

echo "== ap-Ordner statt Link"
rm .claude/skills/ap-requirement-capture
mkdir .claude/skills/ap-requirement-capture
AUSGABE=$(sh _agent-process/init.sh 2>&1)
enthaelt "Ordner gemeldet" ".claude/skills/ap-requirement-capture ist ein Ordner"
pruefe "Ordner bleibt" test -d .claude/skills/ap-requirement-capture -a ! -L .claude/skills/ap-requirement-capture

echo "== .claude/skills als Link"
rm -rf .claude/skills
ln -s ../_agent-process/skills .claude/skills
AUSGABE=$(sh _agent-process/init.sh 2>&1)
enthaelt "Link gemeldet" ".claude/skills ist ein Link"
pruefe "Link bleibt" [ -L .claude/skills ]
enthaelt_nicht "keine Meldung je Skill" "ist ein Ordner"

echo
if [ "$F" -eq 0 ]; then echo "Alle Prüfungen bestanden."; else echo "$F Prüfung(en) fehlgeschlagen."; fi
[ "$F" -eq 0 ]
