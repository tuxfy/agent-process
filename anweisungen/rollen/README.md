# Rollen für Prüfungen

-   Unabhängige Prüfer mit frischem Blick; ändern nichts am Projekt.
-   Wann welche Rolle prüft: jeweilige Stufe (3c, 5a, 6, 8b) bzw. Skill.
-   Laufen in Claude Code als Unteragenten (`.claude/agents/`), sonst als eigene Sitzung je Rolle; mehrere parallel, der Agent führt die Ergebnisse zusammen.
-   Diff für Reviewer, Security und Testwirkung (6b): Der Agent schreibt ihn vor jedem Lauf neu nach `.qa/diff.txt`, wenn alles committet ist: `git fetch`, dann `git diff origin/<Ziel>...HEAD`. Ziel ist das Ziel des Pull Requests: `release-candidate`; bei der Abkürzung oder ohne `release-candidate`: `main`.
-   Datei je Rolle: `<rolle>.md` in diesem Ordner.

## Blick je Rolle

-   **Design (3c):** Entwurf (Abläufe, Zustände, Design-System, Brief, Umsetzbarkeit) · Barrierefreiheit (Kontrast, Namen, Fokus, Tippflächen)
-   **Plan:** Architekt (Aufbau, Schnitt, Abhängigkeiten, Größe) · Senior Dev (Code, Tests, Reihenfolge, Fehlerfälle, Umgebung und Container) · DevOps (ab dem Commit: CI, Hosting, Release, Betrieb)
-   **Umsetzung:** Reviewer (Code gegen Anforderung, Plan, Entscheidungen) · Security (Sicherheit nach Checkliste) · Testwirkung (würden die Tests Fehler finden?) · Klicktester (laufende App wie ein Mensch)
-   **Vorlage an den Nutzer:** Challenger (Behauptungen am Code, frühere Entscheidungen, einfachere Wege)
-   **Planung** (`ap-planning`, kein Prüfer): Vorschlag zu Ziel, Reihenfolge und Verbindungen der offenen Issues; Grundlage und Form in `planung.md`.

## Für alle Rollen

-   **Lesen:** Anforderung (inkl. `# Umsetzungsplan`), `_context/`, `AGENTS.md` des Projekts, `_agent-process/AGENTS.md`, betroffene `_agent-process/anweisungen/`; bei UI `_agent-process/skills/ap-guideline-ui/SKILL.md`; bei Design den Entwurf unter `_requirements/mockups/<kurzer-name>/`; Code nach Bedarf.
-   **Nichts ändern:** keine Dateien, keine Befehle mit Wirkung. Ausnahme: Klicktester startet die App und legt Screenshots unter `.qa/` ab (nicht committet).
-   **Nur im eigenen Blick;** Fremdes höchstens kurz erwähnen.
-   **Entscheidungen der Anforderung nicht neu verhandeln** (Stack, Verhalten, Umfang). Hält eine nicht: Befund mit Begründung; sie geht zurück ins Refinement (beim Entwurf: in die Klärung).
-   **Vertraulichkeit:** keine Namen, Links, Zugangsdaten in Befunden.

## Ergebnis

-   Liste von Befunden **ohne Schweregrad**; einstufen macht der Agent.
-   Je Befund: **was** (ein Satz), **warum** (Folge, wenn es bleibt; durch diese Änderung oder schon vorher), **Vorschlag** (konkrete Änderung an Entwurf, Plan bzw. Umsetzung).
-   Nicht Prüfbares als **offene Frage** dazu.
-   Ohne Befund: ausdrücklich „keine Befunde"; nichts künstlich finden.
