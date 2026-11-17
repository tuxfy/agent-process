# Kurzer Weg (Track `quick`)

Plan und Umsetzung in einem, für Anforderungen mit Track `quick` (Kriterien: `_agent-process/skills/ap-requirement-refine/klaeren.md`, „Was der Agent macht", Schritt 6). Voraussetzung: Status `refined` bzw. `in progress`, Track `quick`, auf dem Feature-Branch. Eine Freigabe des Plans gibt es nicht — die nächste Freigabe des Nutzers ist die Abnahme.

## Start

-   Status `in progress` (und ggf. Umbenennen) wie in `_agent-process/skills/ap-requirement-build/umsetzen.md`, 5b — nach „später" erst auf das Wort des Nutzers (`_agent-process/AGENTS.md`, Abschnitt „Halten"); Commit `chore(<kurzer-name>): Start`.
-   **Im Gespräch** in zwei, drei Sätzen, was umgesetzt wird, das in Stufe 4 gewählte Minimum und die Akzeptanzkriterien — kein Halt, der Nutzer kann eingreifen.

## Plan als Notiz

-   Unter `# Umsetzungsplan` nur: Schritte (meist einer), betroffene Dateien, Testfälle je Akzeptanzkriterium; die übrigen Punkte der Gliederung mit „entfällt (quick)".
-   Selbstprüfung mit den Prüfpunkten der Rollen wie in 5a (`_agent-process/skills/ap-requirement-build/planen.md`); keine Prüfung durch Rollen.
-   Die Notiz wird mit dem ersten Commit der Umsetzung committet.

## Umsetzen

-   Test zuerst, Umsetzen und Grün wie in `_agent-process/skills/ap-requirement-build/umsetzen.md`, 5c–5e; Commits wie dort.
-   Danach Status `qa`, weiter mit `_agent-process/skills/ap-requirement-build/qa.md` — Umfang laut Tabelle dort.

## Abbruch

Der Agent hört auf und plant neu, sobald

1.  etwas fehlt, das der Nutzer am Ergebnis merken würde,
2.  ein Schritt sich nicht rückgängig machen lässt (gespeicherte Daten, Schnittstellen, Auslieferung), oder
3.  die Änderung größer wird als in der Notiz geplant (z. B. ein neues Paket).

Dann: nicht Committetes dieser Anforderung zurücksetzen — nur Dateien, die der Agent dafür geändert oder angelegt hat (`git restore <Pfad>`, eigene neue Dateien entfernen); alles andere, z. B. Dateien des Nutzers, bleibt (`_agent-process/AGENTS.md`, Abschnitt „Git"); hatte eine solche Datei schon vorher nicht Committetes: nicht zurücksetzen, anhalten und fragen; Grund unter `# Umsetzungsplan → Annahmen und Risiken`, Track auf `complete`, Status `in progress` (aus `qa` bzw. `review` zurück), Commit `chore(<kurzer-name>): Track complete`, dem Nutzer sagen. Weiter mit 5a (`_agent-process/skills/ap-requirement-build/planen.md`) — Prüfung durch Rollen laut 5a, Freigabe des Plans. Grün committeter Code bleibt.

Zurück auf `quick` nie still — nur auf ausdrückliches Wort des Nutzers.

Die Abbruchgründe gelten bei `quick` auch für Korrekturen in QA (6c) und Abnahme (7b).
