# Stufe 4: Refinement

Aus dem geklärten (und ggf. entworfenen) Anliegen wird eine **umsetzbare Anforderung**. Am Ende setzt der Agent `refined`; der Nutzer bestätigt es mit der Freigabe des Plans (5a; bei Track `quick` siehe unten).

Voraussetzung: Klärung committet und im committeten Dokument „Design nötig? nein" — oder ein Entwurf ist committet (Stufe 3c); bei der ersten Anforderung aus Stufe 0 (`grundgeruest`) entfällt das. Sonst nicht beginnen; soll Stufe 3 entfallen, gilt die Regel „Bestätigtes ändert nur der Nutzer" (`_agent-process/AGENTS.md`, Abschnitt „Halten").

## Was der Agent macht

1.  **Entscheidungen bündeln** 
    - alles, was in Klärung, Entwurf und hier festgelegt wird, in den Abschnitt „Entscheidungen" (je Punkt kurz: was, ggf. warum)
    - Beantwortete Fragen wandern aus „Offene Fragen" dorthin
    - wenn Design, immer prüfen, ob Hintergrund und Design-Brief noch zum aktuellen Stand passen 
2.  **Technik klären** 
    - vor `refined`
    - Grundlage: `_context/projekt.md` und, wenn es sie gibt, `_context/architektur.md`
    - Best Practices und vorhandene Standards gegen den IST Zustand abwägen -> Best Practices und Standards haben Vorrang ggf. ist der Aufwand jedoch mit dem Nutzer abzustimmen, wenn der Scope des Tasks dadurch wächst
    - hier nur, was **diese Anforderung** zusätzlich braucht oder wo sie abweicht
    - Welche Lösung erreicht das Ziel (Zeile „Ziel" unter „Einordnung")? -> Ist Aufgabe des Agenten
        1.  **Vorhandenes nachlesen:**  
            - Code, 
            - Konfiguration und 
            - Daten des Projekts
        2.  **Übliche Praxis bzw. Standard nachschlagen:** 
            - Nachschlagen. Nicht aus dem Gedächtnis
            - Nichts tun abwägen. Minimaler Aufwand bei höchsten Nutzen.
        3.  **Vergleich vorlegen:**, 
            - je Lösung in einem Satz, was sie neu baut und speichert
    - **Minimum nicht möglich:**
        - Agent nennt der Grund des Mehrnutzen. 
    - In „Entscheidungen" stehen danach 
        - die gewählte Lösung, 
        - das Minimum, wenn es nicht gewählt ist, und 
        - die übrigen mit dem Grund, warum nicht, 
        - dazu die Quellen von Best Practice und Standards bzw. „nicht nachgeschlagen (Annahme)". 
    - Bei Track `quick` nimmt Agent immer Minimum, sofern die Punkte für `quick` weiter zutreffen (`_agent-process/skills/ap-requirement-refine/klaeren.md` -> empfiehlt Agent er mehr oder trifft ein Punkt nicht mehr zu, wird der Track `complete` und für Nutzer sichtbar.
    - Lösungen immer messen an Best Pratices, Standards, KISS, Minimum -> Größeres oder Eigenbau immer mit Bergründung
    -   Neue Bausteine, Bibliotheken oder Werkzeuge?
    -   Wie werden Daten gespeichert?
    -   Welche externen Abhängigkeiten gibt es (Schnittstellen, Dienste, Bibliotheken, auch Hosting und Auslieferung)? Für jede: ist das How-to bekannt oder muss es vor der Umsetzung geklärt werden?
    -   Was lässt sich nur am echten Gerät prüfen?
    - Fehlt in `_context/projekt.md` etwas Grundlegendes (Stack, Prüfungen, Auslieferung, Abnahme): nicht in der Anforderung entscheiden, sondern Stufe 0 für diesen Teil nachholen. Ändert die Anforderung Bausteine, Erreichbarkeit, Vertrauensgrenzen oder Daten: als Entscheidung festhalten, dass die Umsetzung `_context/architektur.md` nachzieht; gibt es die Datei noch nicht und trifft dadurch erstmals ein Grund aus Stufe 0, Punkt 10, zu: sie dem Nutzer vorschlagen; bestätigt er, entsteht sie in der Umsetzung dieser Anforderung.
    - Der Agent schlägt vor, **der Nutzer entscheidet** (Ausnahme bei Track `quick`: das Minimum, siehe oben). Ergebnis in „Entscheidungen".
3.  **Verhalten beschreiben** — was der Nutzer sieht und tut, aus seiner Sicht. Bei Design aus dem Entwurf.
4.  **Akzeptanzkriterien** 
    - jedes prüfbar und abgrenzbar
    - mindestens eines zeigt, dass das Ziel (Zeile „Ziel" unter „Einordnung") erreicht ist
    - Die Standardzeilen der Tabelle (aus der Vorlage) bleiben stehen
    - fehlt eine, aus der Vorlage ergänzen
    - trifft eine nicht zu, mit „entfällt" und Grund markiere
5.  **Teststrategie** 
    - je Kriterium, wie es geprüft wird: Unit-Test, E2E-Test oder manuell (z. B. am Gerät). 
    - Was nur mit dem echten Werkzeug, Dienst oder Gerät sinnvoll prüfbar ist (z. B. ein Skript, das vor allem ein externes Werkzeug aufruft): manuell — durch den Nutzer in der Abnahme bzw. beim Nachprüfen, nicht über eine nachgebaute Attrappe. 
    - Ist kein Kriterium automatisch testbar: Standardzeile „Test … ohne die Änderung rot" mit „entfällt" und Grund
6.  **Abgrenzung**
    - was ausdrücklich **nicht** dazugehört (ggf. mit Verweis auf eigene Issues; 
    - ein bewusst abgetrenntes Ziel, das niemand gerade will, als Eintrag in `_requirements/deferred/` 
    - Regeln in der `README.md` dort, committet mit dem Refinement)
7.  **Technische Notizen** 
    - erlaubt, aber nicht bindend (z. B. betroffene Dateien, Hinweise für die Umsetzung)
8.  **Größe prüfen** 
    - passt die Anforderung in einen Umsetzungsdurchgang? Wenn nicht: aufteilen, Teile als eigene Issues festhalten (Stufe 1).

## Definition of Ready

`refined` erst, wenn alles erfüllt ist:

-   [ ] Keine offenen Fragen
-   [ ] Entscheidungen festgehalten, inkl. Technik; Grundlegendes steht in `_context/projekt.md` (Stufe 0)
-   [ ] Verhalten beschrieben
-   [ ] Jedes Akzeptanzkriterium prüfbar und mit Teststrategie
-   [ ] Abgrenzung formuliert
-   [ ] Bei Design: Entwurf freigegeben und abgelegt
-   [ ] Größe passt
-   Sind alle Punkte erfüllt, setzt **der Agent** den Status `refined`. Fehlt der Track oder ist er nicht gesetzt: `complete` eintragen. Trifft ein Punkt für `quick` (`_agent-process/skills/ap-requirement-refine/klaeren.md`, „Was der Agent macht", Schritt 6) nicht mehr zu: Track `complete`, dem Nutzer sagen.
    -   **Track `complete`:** weiter direkt zum Plan (Stufe 5a, `_agent-process/skills/ap-requirement-build/planen.md`). Der Nutzer bestätigt das Refinement zusammen mit der Freigabe des Plans — eine Antwort statt zwei. Will er am Refinement etwas ändern, geht es von dort zurück.
    -   **Track `quick`:** weiter mit `_agent-process/skills/ap-requirement-build/kurzer-weg.md`. Eine eigene Bestätigung des Refinements gibt es nicht; der Agent nennt beim Start die gewählte Lösung (mit der verworfenen) und die Akzeptanzkriterien.

## Übergang

-   **Dann committet und pusht der Agent** auf dem Feature-Branch (`chore(<kurzer-name>): Refinement, Status refined`), ohne Rückfrage — Statuswechsel und ggf. Einträge in `_requirements/deferred/` in einem Commit.
