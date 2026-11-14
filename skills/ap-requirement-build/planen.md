# Stufe 5a: Plan

Voraussetzung: Status `refined` — bzw. `in progress` nach Abbruch des kurzen Wegs (Commit `chore(<kurzer-name>): Track complete`) — Dokument liegt in `_requirements/`, auf dem Branch der Anforderung (angelegt in Stufe 2, bei `grundgeruest` in Stufe 0). Konkrete Befehle (Tests, Start, Deploy) stehen in `_context/projekt.md`.

Der Agent schreibt den Plan in den Abschnitt `# Umsetzungsplan` des Anforderungsdokuments (Gliederung dort) — **keine eigene Datei**, **knapp**, ohne zu wiederholen, was in der Anforderung schon steht. Dabei: Schritte in Reihenfolge, jeder klein genug für einen Testlauf; betroffene Dateien, bestehende und neue; Testfälle je Akzeptanzkriterium mit Name und erwartetem Ergebnis; bei Design, welches Entwurfselement zu welcher Komponente bzw. Code-Stelle wird; je externer Abhängigkeit (Schnittstellen, Dienste, Bibliotheken, Hosting), wo das **How-to** steht (siehe unten); „Nicht angefasst" aus Spielraum und Abgrenzung.

**Externe Abhängigkeiten — How-to vorher klären.** Bevor Code gegen eine externe Abhängigkeit geschrieben wird, ist geklärt und festgehalten (in `_context/` bzw. der Anforderung):

-   wie sie funktioniert (Dokumentation, Formate, Beispiele),
-   wie der Zugang läuft (ohne Zugangsdaten im Dokument — nur, wo sie liegen bzw. wer sie bereitstellt),
-   wie sie geprüft wird — mit dem echten Werkzeug bzw. Dienst, einer Testumgebung des Anbieters oder manuell (Teststrategie der Anforderung); keine nachgebaute Attrappe des Werkzeugs selbst. Eigene Logik wird vom Aufruf getrennt und für sich getestet; geht das nicht, Grund unter „Annahmen und Risiken",
-   Grenzen und Fehlerfälle (z. B. Limits, Ausfälle, offline).

Ist etwas davon offen: nicht anfangen, sondern mit dem Nutzer klären — ggf. zurück ins Refinement. Ein kurzer, wegwerfbarer Versuch zum Klären ist erlaubt, wenn der Nutzer zustimmt.

**Grundsatzfrage** im Plan (Architektur, Verhalten, Umfang) → zurück ins Refinement.

**Plan prüfen**, bevor er dem Nutzer vorgelegt wird:

1.  **Selbstprüfung — immer:** Der Agent prüft den Plan mit den Prüfpunkten der Rollen (`_agent-process/anweisungen/rollen/`), soweit sie den Plan betreffen, und bessert nach.
2.  **Prüfung durch Rollen** (Prüfer-Rollen, siehe `_agent-process/anweisungen/rollen/README.md`):
    -   **Architekt** und **Senior Dev:** bei neuem Projekt oder Grundgerüst, neuen externen Abhängigkeiten oder einem Plan ab etwa fünf Schritten.
    -   **DevOps** zusätzlich, wenn der Plan CI, Hosting, Auslieferung oder das Release-Modell berührt.
    -   Sonst genügt die Selbstprüfung.
3.  **Befunde einordnen** (`_agent-process/anweisungen/rollen/README.md`, „Einstufung"): „umsetzen" in den Plan einarbeiten; „zurückstellen" als Eintrag bzw. Issue, mit Dateiname bzw. Nummer, und „verwerfen" und „vermerken" mit Grund — alle drei unter „Annahmen und Risiken".
4.  **„Entscheiden"** legt der Agent dem Nutzer mit der Zusammenfassung vor (unten), in Alltagssprache, bei widersprechenden Rollen mit beiden Sichtweisen. Seine Antwort fließt vor der Freigabe in den Plan; weitet sie Anliegen oder eine Entscheidung aus oder schränkt sie ein, gilt `_agent-process/AGENTS.md`, Abschnitt „Halten" (Bestätigtes ändert nur der Nutzer).

**Zusammenfassung für den Nutzer** — kurz, in Alltagssprache, nicht im Dokument, sondern im Gespräch:

-   **Was passiert:** drei bis fünf Sätze.
-   **Was du entscheiden oder liefern musst** (z. B. eine Einstellung bestätigen, einmal einen Befehl ausführen) — dazu die Befunde laut „Einstufung", „Dem Nutzer".
-   **Was riskant ist** und wie damit umgegangen wird.
-   **Wer geprüft hat** und was sich dadurch am Plan geändert hat.

Abschluss: Der **Nutzer gibt den Plan frei** — und bestätigt damit auch das Refinement (Stufe 4) — er beurteilt Umfang, Entscheidungen und Risiken; die technische Güte sichern Selbstprüfung und Rollen. **Der Agent committet den freigegebenen Plan samt Einträgen in `_requirements/deferred/` sofort und pusht den Branch** (`chore(<kurzer-name>): Umsetzungsplan`); Status bleibt bis zum Start `refined`. Ein eigenes „Go" gibt es nicht: Weiter direkt mit 5b (`_agent-process/skills/ap-requirement-build/umsetzen.md`) — außer der Nutzer hat „später" gesagt (`_agent-process/AGENTS.md`, Abschnitt „Halten").

**Nach Abbruch des kurzen Wegs:** Status bleibt `in progress` — 5b entfällt. Nach der Freigabe weiter mit `_agent-process/skills/ap-requirement-build/umsetzen.md` ab dem ersten offenen Schritt.
