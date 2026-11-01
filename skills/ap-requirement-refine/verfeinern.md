# Stufe 4: Refinement

Aus der geklärten (und ggf. entworfenen) Idee wird eine **umsetzbare Anforderung**. Am Ende setzt der Agent `refined`; der Nutzer bestätigt es mit der Freigabe des Plans (5a; bei Track `quick` siehe unten).

Voraussetzung: Klärung committet und im committeten Dokument „Design nötig? nein" — oder ein Entwurf ist committet (Stufe 3c); bei der ersten Anforderung aus Stufe 0 (`grundgeruest`) entfällt das. Sonst nicht beginnen; soll Stufe 3 entfallen, gilt die Regel „Bestätigtes ändert nur der Nutzer" (`_agent-process/AGENTS.md`, Abschnitt „Halten").

## Was der Agent macht

1.  **Entscheidungen bündeln** — alles, was in Klärung, Entwurf und hier festgelegt wird, in den Abschnitt „Entscheidungen" (je Punkt kurz: was, ggf. warum). Beantwortete Fragen wandern aus „Offene Fragen" dorthin. Dabei prüfen, ob Hintergrund und Design-Brief noch zum aktuellen Stand passen — besonders nach einer Auffrischung des Design-Systems (z. B. Verweise auf Teile, die es nicht mehr gibt).
2.  **Technik klären** — vor `refined`, damit in der Umsetzung keine Architekturentscheidung ohne den Nutzer fällt. Grundlage sind die Festlegungen aus Stufe 0 in `_context/projekt.md`; hier nur, was **diese Anforderung** zusätzlich braucht oder wo sie abweicht, soweit relevant:
    -   Neue Bausteine, Bibliotheken oder Werkzeuge?
    -   Wie werden Daten gespeichert?
    -   Welche externen Abhängigkeiten gibt es (Schnittstellen, Dienste, Bibliotheken, auch Hosting und Auslieferung)? Für jede: ist das How-to bekannt oder muss es vor der Umsetzung geklärt werden?
    -   Was lässt sich nur am echten Gerät prüfen?

    Fehlt in `_context/projekt.md` etwas Grundlegendes (Stack, Prüfungen, Auslieferung, Abnahme): nicht in der Anforderung entscheiden, sondern Stufe 0 für diesen Teil nachholen.

    Der Agent schlägt vor, **der Nutzer entscheidet**. Ergebnis in „Entscheidungen".
3.  **Verhalten beschreiben** — was der Nutzer sieht und tut, aus seiner Sicht. Bei Design aus dem Entwurf.
4.  **Akzeptanzkriterien** — jedes prüfbar und abgrenzbar. Die Standardzeilen der Tabelle (aus der Vorlage) bleiben stehen; fehlt eine, aus der Vorlage ergänzen; trifft eine nicht zu, mit „entfällt" und Grund markieren.
5.  **Teststrategie** — je Kriterium, wie es geprüft wird: Unit-Test, E2E-Test oder manuell (z. B. am Gerät).
6.  **Abgrenzung** — was ausdrücklich **nicht** dazugehört (ggf. mit Verweis auf eigene Ideen im Backlog; ein bewusst abgetrenntes Ziel, das niemand gerade will, als Eintrag in `_requirements/deferred/` — Regeln in der `README.md` dort, committet mit dem Refinement).
7.  **Technische Notizen** — erlaubt, aber nicht bindend (z. B. betroffene Dateien, Hinweise für die Umsetzung).
8.  **Größe prüfen** — passt die Anforderung in einen Umsetzungsdurchgang? Wenn nicht: aufteilen, Teile als eigene Anforderungen im Backlog.

## Definition of Ready

`refined` erst, wenn alles erfüllt ist:

-   [ ] Keine offenen Fragen
-   [ ] Entscheidungen festgehalten, inkl. Technik; Grundlegendes steht in `_context/projekt.md` (Stufe 0)
-   [ ] Verhalten beschrieben
-   [ ] Jedes Akzeptanzkriterium prüfbar und mit Teststrategie
-   [ ] Abgrenzung formuliert
-   [ ] Bei Design: Entwurf freigegeben und abgelegt
-   [ ] Größe passt
-   Sind alle Punkte erfüllt, setzt **der Agent** den Status `refined`. Fehlt der Track oder ist er nicht gesetzt: `complete` eintragen. Trifft ein Punkt für `quick` (`_agent-process/skills/ap-requirement-refine/klaeren.md`, Schritt 5) nicht mehr zu: Track `complete`, dem Nutzer sagen.
    -   **Track `complete`:** weiter direkt zum Plan (Stufe 5a, `_agent-process/skills/ap-requirement-build/planen.md`). Der Nutzer bestätigt das Refinement zusammen mit der Freigabe des Plans — eine Antwort statt zwei. Will er am Refinement etwas ändern, geht es von dort zurück.
    -   **Track `quick`:** weiter mit `_agent-process/skills/ap-requirement-build/kurzer-weg.md`. Eine eigene Bestätigung des Refinements gibt es nicht; der Agent nennt die Akzeptanzkriterien beim Start.

## Übergang

-   Bei `refined` wandert das Dokument (auf dem Feature-Branch) von `_requirements/backlog/` nach `_requirements/` — **ohne Nummer**, Dateiname bleibt `<kurzer-name>.md`.
-   **Dann committet und pusht der Agent** auf dem Feature-Branch (`chore(<kurzer-name>): Refinement, Status refined`), ohne Rückfrage — Verschieben, Statuswechsel und ggf. Einträge in `_requirements/deferred/` in einem Commit.
-   Die Nummer wird erst beim **Start der Umsetzung** vergeben (5b bzw. kurzer Weg).
