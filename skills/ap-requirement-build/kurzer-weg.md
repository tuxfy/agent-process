# Kurzer Weg (Track `quick`)

Plan und Umsetzung in einem, für Track `quick` (Kriterien: `_agent-process/skills/ap-requirement-refine/klaeren.md`, „Was der Agent macht", Schritt 6).

-   **Voraussetzung:** Status `refined` bzw. `in progress`, Track `quick`, auf dem Feature-Branch.
-   **Keine Plan-Freigabe;** nächste Freigabe des Nutzers ist die Abnahme.

## Start

-   Status `in progress` (ggf. Umbenennen) wie in `_agent-process/skills/ap-requirement-build/umsetzen.md`, 5b; nach „später" erst auf das Wort des Nutzers (`_agent-process/AGENTS.md`, „Halten"). Commit `chore(<kurzer-name>): Start`.
-   **Im Gespräch,** zwei, drei Sätze: was umgesetzt wird, das in Stufe 4 gewählte Minimum, die Akzeptanzkriterien. Kein Halt; der Nutzer kann eingreifen.

## Plan als Notiz

-   Unter `# Umsetzungsplan` nur: Schritte (meist einer), betroffene Dateien, Testfälle je Akzeptanzkriterium; übrige Punkte der Gliederung: „entfällt (quick)".
-   Selbstprüfung mit den Prüfpunkten der Rollen wie in 5a (`_agent-process/skills/ap-requirement-build/planen.md`); keine Prüfung durch Rollen.
-   Notiz kommt mit dem ersten Commit der Umsetzung.

## Umsetzen

-   Test zuerst, Umsetzen, Grün und Commits wie in `_agent-process/skills/ap-requirement-build/umsetzen.md`, 5c–5e.
-   Danach Status `qa`, weiter mit `_agent-process/skills/ap-requirement-build/qa.md` (Umfang laut Tabelle dort).

## Abbruch

Aufhören und neu planen, sobald:

1.  etwas fehlt, das der Nutzer am Ergebnis merken würde;
2.  ein Schritt sich nicht rückgängig machen lässt (gespeicherte Daten, Schnittstellen, Auslieferung);
3.  die Änderung größer wird als in der Notiz geplant (z. B. neues Paket).

Dann:

1.  Nicht Committetes dieser Anforderung zurücksetzen: nur Dateien, die der Agent dafür geändert oder angelegt hat (`git restore <Pfad>`, eigene neue Dateien entfernen). Alles andere bleibt, z. B. Dateien des Nutzers (`_agent-process/AGENTS.md`, „Git"). Hatte eine solche Datei schon vorher nicht Committetes: nicht zurücksetzen, anhalten und fragen.
2.  Grund unter `# Umsetzungsplan → Annahmen und Risiken`; Track `complete`; Status `in progress` (aus `qa` bzw. `review` zurück); Commit `chore(<kurzer-name>): Track complete`; dem Nutzer sagen.
3.  Weiter mit 5a (`_agent-process/skills/ap-requirement-build/planen.md`): Prüfung durch Rollen laut 5a, Freigabe des Plans. Grün committeter Code bleibt.

-   Zurück auf `quick` nie still, nur auf ausdrückliches Wort des Nutzers.
-   Die Abbruchgründe gelten bei `quick` auch für Korrekturen in QA (6c) und Abnahme (7b).
