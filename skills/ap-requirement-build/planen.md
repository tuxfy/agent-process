# Stufe 5a: Plan

-   **Voraussetzung:** Status `refined`, bzw. `in progress` nach Abbruch des kurzen Wegs (Commit `chore(<kurzer-name>): Track complete`); Dokument in `_requirements/`; auf dem Branch der Anforderung (angelegt in Stufe 2, bei `grundgeruest` in Stufe 0).
-   **Befehle** (Tests, Start, Deploy): `_context/projekt.md`.

## Plan schreiben

In `# Umsetzungsplan` des Anforderungsdokuments (Gliederung dort); **keine eigene Datei**, **knapp**, nichts wiederholen, was schon in der Anforderung steht. Inhalt:

-   Schritte in Reihenfolge, jeder klein genug für einen Testlauf;
-   betroffene Dateien, bestehende und neue;
-   Testfälle je Akzeptanzkriterium mit Name und erwartetem Ergebnis;
-   bei Design: welches Entwurfselement zu welcher Komponente bzw. Code-Stelle wird;
-   je externer Abhängigkeit (Schnittstellen, Dienste, Bibliotheken, Hosting): wo das **How-to** steht (unten);
-   „Nicht angefasst" aus Spielraum und Abgrenzung.

## Externe Abhängigkeiten: How-to vorher klären

Bevor Code gegen eine externe Abhängigkeit entsteht, geklärt und festgehalten (in `_context/` bzw. der Anforderung):

-   wie sie funktioniert (Dokumentation, Formate, Beispiele);
-   wie der Zugang läuft (ohne Zugangsdaten im Dokument; nur, wo sie liegen bzw. wer sie bereitstellt);
-   wie sie geprüft wird: echtes Werkzeug bzw. echter Dienst, Testumgebung des Anbieters oder manuell (Teststrategie der Anforderung); keine nachgebaute Attrappe des Werkzeugs selbst. Eigene Logik vom Aufruf trennen und für sich testen; geht das nicht: Grund unter „Annahmen und Risiken";
-   Grenzen und Fehlerfälle (z. B. Limits, Ausfälle, offline).

Etwas offen → nicht anfangen, mit dem Nutzer klären, ggf. zurück ins Refinement. Kurzer, wegwerfbarer Versuch zum Klären nur mit Zustimmung des Nutzers.

**Grundsatzfrage** im Plan (Architektur, Verhalten, Umfang) → zurück ins Refinement.

## Plan prüfen (vor der Vorlage)

1.  **Selbstprüfung, immer:** Plan mit den Prüfpunkten der Rollen (`_agent-process/anweisungen/rollen/`) prüfen, soweit sie den Plan betreffen; nachbessern.
2.  **Prüfung durch Rollen** (`_agent-process/anweisungen/rollen/README.md`):
    -   **Architekt** und **Senior Dev** bei: neuem Projekt oder Grundgerüst; neuen externen Abhängigkeiten; Plan ab etwa fünf Schritten.
    -   **DevOps** zusätzlich, wenn der Plan CI, Hosting, Auslieferung oder Release-Modell berührt.
    -   Sonst genügt die Selbstprüfung.
3.  **Befunde einordnen** (`_agent-process/anweisungen/einstufung.md`):
    -   „umsetzen" → in den Plan einarbeiten;
    -   „zurückstellen" → Eintrag bzw. Issue, mit Dateiname bzw. Nummer;
    -   „verwerfen", „vermerken" → mit Grund;
    -   „zurückstellen", „verwerfen", „vermerken" stehen unter „Annahmen und Risiken".
4.  **„Entscheiden":**
    -   mit der Zusammenfassung (unten) dem Nutzer vorlegen, nach der Richtlinie `guideline-docs`;
    -   Antwort des Nutzers vor der Freigabe in den Plan;
    -   weitet der Nutzer Anliegen oder Entscheidung aus oder schränkt sie ein: `_agent-process/AGENTS.md`, „Halten";
    -   Bestätigtes ändert nur der Nutzer.

## Zusammenfassung für den Nutzer

Kurz, Alltagssprache, im Gespräch (nicht im Dokument):

-   **Was passiert:** drei bis fünf Sätze.
-   **Was du entscheiden oder liefern musst** (z. B. Einstellung bestätigen, einmal einen Befehl ausführen); dazu die Befunde laut `_agent-process/anweisungen/einstufung.md`, „Dem Nutzer".
-   **Was riskant ist** und wie damit umgegangen wird.
-   **Wer geprüft hat** und was sich dadurch am Plan geändert hat.

## Abschluss

-   **Nutzer gibt den Plan frei** und bestätigt damit auch das Refinement (Stufe 4). Er beurteilt Umfang, Entscheidungen, Risiken; technische Güte sichern Selbstprüfung und Rollen.
-   **Sofort committen und pushen:** freigegebener Plan samt Einträgen in `_requirements/deferred/` (`chore(<kurzer-name>): Umsetzungsplan`). Status bleibt bis zum Start `refined`.
-   Kein eigenes „Go": direkt weiter mit 5b (`_agent-process/skills/ap-requirement-build/umsetzen.md`), außer nach „später" (`_agent-process/AGENTS.md`, „Halten").
-   **Nach Abbruch des kurzen Wegs:** Status bleibt `in progress`, 5b entfällt; nach der Freigabe weiter mit `_agent-process/skills/ap-requirement-build/umsetzen.md` ab dem ersten offenen Schritt.
