# Stufe 4: Refinement

Aus dem geklärten (ggf. entworfenen) Anliegen wird eine **umsetzbare Anforderung**. Am Ende setzt der Agent `refined`; der Nutzer bestätigt es mit der Plan-Freigabe (5a; bei Track `quick` siehe unten).

**Voraussetzung:** Klärung committet und im committeten Dokument „Design nötig? nein", oder Entwurf committet (3c); bei der ersten Anforderung aus Stufe 0 (`grundgeruest`) entfällt das. Sonst nicht beginnen. Soll Stufe 3 entfallen: „Bestätigtes ändert nur der Nutzer" (`_agent-process/AGENTS.md`, „Halten").

## Was der Agent macht

1.  **Entscheidungen bündeln:**
    -   alles, was in Klärung, Entwurf und hier festgelegt wird, in „Entscheidungen" (je Punkt kurz: was, ggf. warum);
    -   beantwortete Fragen wandern aus „Offene Fragen" dorthin;
    -   bei Design: prüfen, ob Hintergrund und Design-Brief noch zum aktuellen Stand passen.
2.  **Technik klären** (vor `refined`):
    -   Grundlage: `_context/projekt.md`, falls vorhanden `_context/architektur.md`;
    -   Best Practices und vorhandene Standards gegen den Ist-Zustand abwägen; sie haben Vorrang, wächst dadurch der Umfang: Aufwand mit dem Nutzer abstimmen;
    -   nur, was **diese Anforderung** zusätzlich braucht oder wo sie abweicht.
    -   **Welche Lösung erreicht das Ziel** (Zeile „Ziel" unter „Einordnung")? Aufgabe des Agenten:
        1.  **Vorhandenes nachlesen:** Code, Konfiguration, Daten des Projekts.
        2.  **Übliche Praxis bzw. Standard nachschlagen:** nicht aus dem Gedächtnis; Nichts-Tun abwägen; minimaler Aufwand bei höchstem Nutzen.
        3.  **Vergleich vorlegen:** je Lösung ein Satz, was sie neu baut und speichert.
    -   **Minimum nicht möglich:** Grund für den Mehrnutzen nennen.
    -   Lösungen messen an Best Practices, Standards, KISS, Minimum; Größeres oder Eigenbau immer mit Begründung.
    -   In „Entscheidungen" danach: gewählte Lösung; das Minimum, wenn nicht gewählt; die übrigen mit Grund, warum nicht; Quellen von Best Practice und Standards bzw. „nicht nachgeschlagen (Annahme)".
    -   **Track `quick`:** Agent nimmt immer das Minimum, solange die Punkte für `quick` zutreffen (`_agent-process/skills/ap-requirement-refine/klaeren.md`). Empfiehlt er mehr oder trifft ein Punkt nicht mehr zu: Track `complete`, für den Nutzer sichtbar.
    -   Außerdem klären:
        -   neue Bausteine, Bibliotheken, Werkzeuge?
        -   wie werden Daten gespeichert?
        -   externe Abhängigkeiten (Schnittstellen, Dienste, Bibliotheken, auch Hosting und Auslieferung)? Je Abhängigkeit: How-to bekannt oder vor der Umsetzung zu klären?
        -   was lässt sich nur am echten Gerät prüfen?
    -   **Grundlegendes fehlt** in `_context/projekt.md` (Stack, Prüfungen, Auslieferung, Abnahme): nicht in der Anforderung entscheiden; Stufe 0 für diesen Teil nachholen.
    -   **Anforderung ändert Bausteine, Erreichbarkeit, Vertrauensgrenzen oder Daten:** als Entscheidung festhalten, dass die Umsetzung `_context/architektur.md` nachzieht. Gibt es die Datei noch nicht und trifft dadurch erstmals ein Grund aus Stufe 0, Punkt 10, zu: dem Nutzer vorschlagen; bestätigt er, entsteht sie in der Umsetzung dieser Anforderung.
    -   Agent schlägt vor, **Nutzer entscheidet** (Ausnahme Track `quick`: Minimum, siehe oben). Ergebnis in „Entscheidungen".
3.  **Verhalten beschreiben:** was der Nutzer sieht und tut, aus seiner Sicht; bei Design aus dem Entwurf.
4.  **Akzeptanzkriterien:**
    -   jedes prüfbar und abgrenzbar;
    -   mindestens eines zeigt, dass das Ziel (Zeile „Ziel" unter „Einordnung") erreicht ist;
    -   Standardzeilen der Tabelle (aus der Vorlage) bleiben; fehlt eine: aus der Vorlage ergänzen; trifft eine nicht zu: „entfällt" mit Grund.
5.  **Teststrategie:**
    -   je Kriterium: Unit-Test, E2E-Test oder manuell (z. B. am Gerät);
    -   nur mit echtem Werkzeug, Dienst oder Gerät sinnvoll prüfbar (z. B. Skript, das vor allem ein externes Werkzeug aufruft): manuell, durch den Nutzer in der Abnahme bzw. beim Nachprüfen; keine nachgebaute Attrappe;
    -   kein Kriterium automatisch testbar: Standardzeile „Test … ohne die Änderung rot" mit „entfällt" und Grund.
6.  **Abgrenzung:**
    -   was ausdrücklich **nicht** dazugehört (ggf. Verweis auf eigene Issues);
    -   bewusst abgetrenntes Ziel, das niemand gerade will → Eintrag in `_requirements/deferred/` (Regeln in der `README.md` dort), committet mit dem Refinement.
7.  **Technische Notizen:** erlaubt, nicht bindend (z. B. betroffene Dateien, Hinweise für die Umsetzung).
8.  **Größe prüfen:** passt in einen Umsetzungsdurchgang? Sonst aufteilen, Teile als eigene Issues (Stufe 1).

## Definition of Ready

`refined` erst, wenn alles erfüllt:

-   [ ] Keine offenen Fragen
-   [ ] Entscheidungen festgehalten, inkl. Technik; Grundlegendes steht in `_context/projekt.md` (Stufe 0)
-   [ ] Verhalten beschrieben
-   [ ] Jedes Akzeptanzkriterium prüfbar und mit Teststrategie
-   [ ] Abgrenzung formuliert
-   [ ] Bei Design: Entwurf freigegeben und abgelegt
-   [ ] Größe passt

Dann:

-   **Agent** setzt Status `refined`. Track fehlt oder nicht gesetzt: `complete` eintragen. Trifft ein Punkt für `quick` (`_agent-process/skills/ap-requirement-refine/klaeren.md`, „Was der Agent macht", Schritt 6) nicht mehr zu: Track `complete`, dem Nutzer sagen.
-   **Track `complete`:** direkt weiter zum Plan (5a, `_agent-process/skills/ap-requirement-build/planen.md`). Nutzer bestätigt das Refinement mit der Plan-Freigabe; eine Antwort statt zwei. Will er am Refinement etwas ändern, geht es von dort zurück.
-   **Track `quick`:** weiter mit `_agent-process/skills/ap-requirement-build/kurzer-weg.md`. Keine eigene Bestätigung des Refinements; beim Start nennt der Agent die gewählte Lösung (mit der verworfenen) und die Akzeptanzkriterien.

## Übergang

-   **Committen und pushen,** ohne Rückfrage, auf dem Feature-Branch (`chore(<kurzer-name>): Refinement, Status refined`): Statuswechsel und ggf. Einträge in `_requirements/deferred/` in einem Commit.
