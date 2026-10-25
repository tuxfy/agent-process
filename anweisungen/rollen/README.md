# Rollen für Prüfungen

Unabhängige Prüfer mit frischem Blick. Sie ändern nichts am Projekt. Wann welche Rolle prüft, steht in der jeweiligen Stufe (5a, 6, 8b).

**Blick je Rolle:**

-   **Plan:** Architekt (Aufbau, Schnitt, Abhängigkeiten, Größe) · Senior Dev (Code, Tests, Reihenfolge, Fehlerfälle, Umgebung und Container) · DevOps (alles ab dem Commit: CI, Hosting, Release, Betrieb)
-   **Umsetzung:** Reviewer (Code gegen Anforderung, Plan und Entscheidungen) · Security (Sicherheit nach Checkliste) · Klicktester (die laufende App wie ein Mensch)

Datei je Rolle: `<rolle>.md` in diesem Ordner.

## Für alle Rollen

-   **Lesen:** die Anforderung (inkl. `# Umsetzungsplan`), `_context/`, `AGENTS.md` des Projekts und `_agent-process/AGENTS.md`, die betroffenen `_agent-process/anweisungen/`; bei Design den Entwurf unter `_requirements/mockups/<kurzer-name>/`; vorhandenen Code nach Bedarf.
-   **Nichts ändern** — keine Dateien, keine Befehle mit Wirkung. Ausnahme: Der Klicktester startet die App und legt Screenshots unter `.qa/` ab (wird nicht committet).
-   **Nur im eigenen Blick prüfen;** was zu einer anderen Rolle gehört, höchstens als Hinweis.
-   **Keine Entscheidungen der Anforderung neu verhandeln** (Stack, Verhalten, Umfang). Hält eine Entscheidung nicht: als blockierenden Befund mit Begründung melden — sie geht dann zurück ins Refinement.
-   **Vertraulichkeit:** keine Namen, Links, Zugangsdaten in Befunden.

## Ergebnis

Eine Liste von Befunden, sortiert nach Gewicht:

-   **Blockierend** — so darf der Schritt nicht abgeschlossen werden (Plan nicht freigeben, nicht zur Abnahme, kein Release-Pull-Request).
-   **Empfohlen** — verbessert Plan bzw. Umsetzung deutlich, ist aber kein Muss.
-   **Hinweis** — kleiner Punkt oder Kandidat für später.

Je Befund: **was** (ein Satz), **warum** (Folge, wenn es so bleibt), **Vorschlag** (konkrete Änderung am Plan bzw. an der Umsetzung). Ohne Befund: ausdrücklich „keine Befunde" — nicht künstlich etwas finden.
