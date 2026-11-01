# Rollen für Prüfungen

Unabhängige Prüfer mit frischem Blick. Sie ändern nichts am Projekt. Wann welche Rolle prüft, steht in der jeweiligen Stufe (3c, 5a, 6, 8b). In Claude Code laufen sie als Unteragenten (`.claude/agents/`), sonst als eigene Sitzung je Rolle. Mehrere laufen parallel; der Agent führt die Ergebnisse zusammen. Reviewer, Security und Testwirkung (6b) bekommen den Diff als Datei: Der Agent schreibt ihn vor jedem Lauf neu nach `.qa/diff.txt`, wenn alles committet ist: `git fetch`, dann `git diff origin/<Ziel>...HEAD` — Ziel ist das Ziel des Pull Requests (`release-candidate`; bei der Abkürzung oder solange es `release-candidate` noch nicht gibt: `main`).

**Blick je Rolle:**

-   **Design (3c):** Entwurf (Abläufe, Zustände, Design-System, Brief, Umsetzbarkeit) · Barrierefreiheit (Kontrast, Namen, Fokus, Tippflächen)
-   **Plan:** Architekt (Aufbau, Schnitt, Abhängigkeiten, Größe) · Senior Dev (Code, Tests, Reihenfolge, Fehlerfälle, Umgebung und Container) · DevOps (alles ab dem Commit: CI, Hosting, Release, Betrieb)
-   **Umsetzung:** Reviewer (Code gegen Anforderung, Plan und Entscheidungen) · Security (Sicherheit nach Checkliste) · Testwirkung (würden die Tests Fehler finden?) · Klicktester (die laufende App wie ein Mensch)

Datei je Rolle: `<rolle>.md` in diesem Ordner.

## Für alle Rollen

-   **Lesen:** die Anforderung (inkl. `# Umsetzungsplan`), `_context/`, `AGENTS.md` des Projekts und `_agent-process/AGENTS.md`, die betroffenen `_agent-process/anweisungen/`; bei UI-Arbeit `_agent-process/skills/ap-guideline-ui/SKILL.md`; bei Design den Entwurf unter `_requirements/mockups/<kurzer-name>/`; vorhandenen Code nach Bedarf.
-   **Nichts ändern** — keine Dateien, keine Befehle mit Wirkung. Ausnahme: Der Klicktester startet die App und legt Screenshots unter `.qa/` ab (wird nicht committet).
-   **Nur im eigenen Blick prüfen;** was zu einer anderen Rolle gehört, höchstens als Hinweis.
-   **Keine Entscheidungen der Anforderung neu verhandeln** (Stack, Verhalten, Umfang). Hält eine Entscheidung nicht: als Befund mit Begründung melden — sie geht dann zurück ins Refinement (beim Entwurf: in die Klärung).
-   **Vertraulichkeit:** keine Namen, Links, Zugangsdaten in Befunden.

## Ergebnis

Eine Liste von Befunden, **ohne Schweregrad** — die Einstufung macht der Agent (unten). Je Befund: **was** (ein Satz), **warum** (Folge, wenn es so bleibt), **Vorschlag** (konkrete Änderung am Entwurf, am Plan bzw. an der Umsetzung). Was sich nicht prüfen ließ, als **offene Frage** dazu. Ohne Befund: ausdrücklich „keine Befunde" — nicht künstlich etwas finden.

## Einstufung durch den Agenten

Der Agent, der die Prüfer startet, stuft jeden Befund ein — Befunde mehrerer Rollen zur selben Sache als einen, mit Nennung aller Rollen:

-   **Blockierend** — so darf der Schritt nicht abgeschlossen werden (Entwurf bzw. Plan nicht freigeben, nicht zur Abnahme, kein Release-Pull-Request). Immer blockierend:
    -   abgeschwächte Tests;
    -   ein neuer oder geänderter Test, der nie scheitern kann (z. B. eine Prüfung auf Abwesenheit ohne Gegenprobe); bei alten Tests: empfohlen bzw. als Bug ins Backlog;
    -   Tests, die der Plan erst nach ihrem Code vorsieht;
    -   eine Entscheidung der Anforderung, die nicht hält;
    -   eine App, die sich nicht starten oder bedienen lässt;
    -   ein wiederkehrender Handgriff von Hand, wenn jeder Stand automatisch live geht (sonst empfohlen).
-   **Empfohlen** — verbessert Entwurf, Plan bzw. Umsetzung deutlich, ist aber kein Muss.
-   **Hinweis** — kleiner Punkt oder Kandidat für später.
