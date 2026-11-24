# Stufe 2: Klärung

## Beginn

-   **Aufgreifen:** Nutzer greift ein Issue ausdrücklich auf (Branch finden: `_agent-process/skills/ap-requirement-refine/SKILL.md`). Als Aufgreifen gilt auch: bei Fix aus der Gesamtprüfung (8b) der blockierende Befund; bei Anforderung aus Stufe 0 deren Freigabe.
-   Alle Stufen bis zur Abnahme laufen auf dem Branch der Anforderung.
-   **Issue hat schon einen Branch** (Kommentar im Issue): dessen kurzer Name gilt; Branch und Kommentar entfallen; weiter mit „Dokument".

-   **Kurzer Name:**
    -   aus dem Titel, wenige Wörter, nur `a–z`, `0–9`, Bindestrich (ä → ae, ö → oe, ü → ue, ß → ss), z. B. `timer-ton`;
    -   noch nicht vergeben: als Branch (`feature/` oder `fix/`, lokal oder beim Hoster nach `git fetch`), unter `_requirements/` (auch `done/`, Dateien mit oder ohne Nummer davor) oder `_requirements/mockups/`; jeweils hier und nach `git fetch` auf `origin/release-candidate` (`git ls-tree -r --name-only origin/release-candidate _requirements/`; gibt es ihn nicht, entfällt das);
    -   Branch mit diesem Namen vorhanden, aber kein Kommentar im Issue → fragen;
    -   Kennung der Anforderung (Branch, Commits, Dateiname); dem Nutzer gleich zu Beginn nennen.
-   **Branch:**
    -   `fix/<kurzer-name>` bei Label `bug`, sonst `feature/<kurzer-name>`; ohne Label fragen. Die Art („Was der Agent macht", Schritt 3) ändert ihn nicht.
    -   angelegt vom aktuellen `main` (`_agent-process/AGENTS.md`, „Git", „Aktueller Stand"); bei Fix aus 8b vom aktuellen `release-candidate`.
    -   **direkt nach dem Push** ins Issue kommentieren: „Aufgegriffen auf `<Branch>`".
-   **Dokument** `_requirements/<Nr>-<kurzer-name>.md`:
    -   nur, wenn es in keiner Form `*<kurzer-name>.md` schon gibt (älteres `<kurzer-name>.md` wird erst in 5b umbenannt);
    -   `<Nr>` = Issue-Nummer, mit führenden Nullen auf mind. drei Stellen (z. B. `042-timer-ton.md`); Branch, Commits und `mockups/` tragen nur den kurzen Namen;
    -   neu nach `_agent-process/anweisungen/vorlagen/anforderung.md`: Titel aus dem Issue-Titel, `Issue #<Nummer>` (ohne führende Nullen, z. B. `#42`), Status `new`, Zeile `Track` unverändert (`quick | complete`), eingetragen erst beim Abschluss;
    -   „Anliegen": **nur** der Text des Issues, unverändert; nur Sicherheitsdetails abstrakt fassen und Adressen beim Hoster durch `#<Nummer>` ersetzen (`_agent-process/AGENTS.md`, „Grundsätze"). Inhaltlich Neues aus Kommentaren unter „Hintergrund", mit Verweis aufs Issue;
    -   **sofort committen und pushen,** ohne Rückfrage (`chore(<kurzer-name>): Anliegen aus Issue #<Nummer>`; bei Anforderung aus Stufe 0 zusammen mit `_context/`).

Lesen oder Kommentieren geht nicht (Befehl fehlt, keine Rechte, Hoster nicht erreichbar): Nutzer gibt Nummer, Titel, Label, Text, ggf. Kommentare; Agent gibt den Kommentar zum Kopieren aus und arbeitet weiter.

Vor Lösungen klärt der Agent den **Rahmen**.

## Start

-   **Zurückgestelltes durchsehen:** nur lesen, wie in `_requirements/deferred/README.md`; passende Einträge dem Nutzer nennen; er entscheidet, ob sie mit übernommen werden.

## Was der Agent macht

1.  **Ist-Stand beschreiben** (Abschnitt „Hintergrund"):
    -   Wie funktioniert der betroffene Teil heute?
    -   Was wären Best Practices und Standards? Mit Quelle, sonst als (Annahme) markieren.
    -   Bei Bugs: beobachtetes Fehlverhalten.
2.  **Ziel festhalten** (Zeile „Ziel" unter „Einordnung"):
    -   ein Satz, was danach anders ist; prüfbar, ohne festgelegte Lösung;
    -   aus dem Issue (ältere Issues: „Was danach anders sein soll");
    -   fehlt es, steht `offen`, ist es nicht prüfbar oder beschreibt eine Lösung (Technik, Werkzeug, Format) → Ziel vorschlagen aus „Was stört oder fehlt" und dem Zweck einer genannten Lösung; Nutzer fragen;
    -   Lösung wählen ist nicht Klärung, sondern Refinement (Stufe 4);
    -   Label `bug`: Ziel = „Was erwartet war"; übernehmen, nicht fragen.
3.  **Art bestimmen:** Feature, Bug, Design oder technisch.
    -   **Anspruch:** aus `_context/projekt.md` übernehmen. Nur wenn diese Anforderung mehr verlangt (z. B. persönliche Daten, Auslieferung): höheren vorschlagen, mit Grund; nie einen niedrigeren.
    -   Fehlt der Anspruch in `_context/projekt.md`: einmal vorschlagen (Bedeutung: `_agent-process/skills/ap-project-setup/SKILL.md`, „Was festgelegt wird", Punkt 1); nach Bestätigung eintragen.
4.  **Spielraum vorschlagen:** welche Bereiche sich ändern dürfen:
    -   **Darstellung:** wie es aussieht oder formuliert ist;
    -   **Verhalten:** was es aus Nutzersicht tut;
    -   **Struktur:** wie es intern gebaut ist, nach außen unverändert;
    -   **Schnittstellen/Daten:** Formate, gespeicherte Daten, APIs.

    Nicht Angekreuztes bleibt unverändert. **Der Nutzer entscheidet.**

    **So fragen** (nicht abstrakt „Welcher Spielraum?"):
    1.  in ein, zwei Sätzen erklären, wofür der Spielraum da ist: legt fest, was sich ändern darf, schützt alles andere vor ungewollten Änderungen (z. B. Redesign ändert nicht still das Verhalten);
    2.  **konkreter Vorschlag** für genau dieses Anliegen, je Bereich mit kurzer Begründung (z. B. „Verhalten: ja — die Funktion ist neu"; „Schnittstellen/Daten: ja — es wird lokal gespeichert");
    3.  um Bestätigung oder Korrektur bitten.

    **Neues Projekt** ohne bestehenden Stand: meist alles änderbar → kurz sagen statt vier Einzelfragen, alle Bereiche ankreuzen.
5.  **Offene Fragen sammeln:** als Liste, noch ohne Antworten.
6.  **Weg vorschlagen:**
    -   **Design** nötig (→ Stufe 3)?
    -   **Track:** `quick`, wenn alle vier Punkte zutreffen, sonst `complete`; je Punkt kurze Begründung:
        1.  keine offene Frage (Liste aus Schritt 5 leer);
        2.  nichts Unumkehrbares (gespeicherte Daten, Schnittstellen, Auslieferung);
        3.  klein (wenige Dateien; Plan und Umsetzung passen in einen Schritt);
        4.  kein Design.
    -   Bug: siehe „Bugs" unten.

## Was noch nicht hineingehört

Lösungen, Akzeptanzkriterien, Design, Implementierungsdetails.

## Abschluss

1.  Im Gespräch zusammenfassen: Ziel, Art, Anspruch (nur wenn abweichend oder neu), Spielraum, Weg (Design ja/nein, Track), offene Fragen.
2.  **Nutzer bestätigt Ziel, Spielraum, Weg und Track,** dazu den Anspruch, wenn abweichend oder neu. Offene Fragen dürfen bleiben (beantwortet in Stufe 3 bzw. 4); Track ist dann `complete`.
3.  Erst danach Track in Zeile `Track` im Kopf des Dokuments eintragen.
4.  **Committen und pushen,** ohne Rückfrage: Anforderungsdokument, dazu `_context/projekt.md`, wenn dort der Anspruch eingetragen wurde; auf dem Feature-Branch (`chore(<kurzer-name>): Klärung`).

## Bugs

Derselbe Prozess, kürzer; Track nach den vier Punkten in Schritt 6, bei Bugs oft `quick`:

1.  **Klärung (Stufe 2):**
    -   Ursache bestätigen ist Pflicht; Spielraum meist nur „Verhalten" der betroffenen Stelle.
    -   **Pflichtfrage: Welche Prüfung hätte diesen Fehler finden müssen?** Antwort ins Dokument; daraus folgt der Test, der den Fehler zeigt (Regel und Ausnahme: `AGENTS.md`, „Tests").
    -   **Schwere:** aus dem Issue bestätigen lassen bzw., fehlt sie, vorschlagen (Skala: `_agent-process/anweisungen/einstufung.md`); steht unter „Hintergrund", zeigt dem Nutzer die Dringlichkeit; was zuerst behoben wird, entscheidet er.
2.  **Design (Stufe 3):**
    -   meist nicht nötig: bei UI-Bug steht das erwartete Aussehen fest (freigegebener Entwurf, Design-System); dorthin korrigieren;
    -   **nötig,** wenn die Korrektur eine neue Gestaltungsentscheidung braucht (z. B. Fall, den weder Entwurf noch Design-System abdecken); dann wie Stufe 3, Entscheidung in der Klärung.
3.  **Refinement (Stufe 4):** kurz: Ursache, erwartetes Verhalten, Kriterium „Test zeigt den Fehler (rot), nach der Korrektur grün".
4.  **Umsetzung (Stufe 5):** auf `fix/<kurzer-name>` (ab Stufe 2); zuerst der Test, der den Fehler zeigt.
5.  **QA (Stufe 6):** Umfang laut Tabelle in `_agent-process/skills/ap-requirement-build/qa.md`.
6.  **Abnahme und Release (Stufen 7, 8):** wie sonst; Release nur mit Bugs erhöht die Patch-Version (z. B. `v0.1.1`).
