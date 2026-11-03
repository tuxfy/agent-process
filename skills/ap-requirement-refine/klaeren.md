# Stufe 2: Klärung

**Beginn:** Der Nutzer greift ein Issue ausdrücklich auf (Branch finden: `_agent-process/skills/ap-requirement-refine/SKILL.md`); bei einem Fix aus der Gesamtprüfung (8b) gilt der blockierende Befund, bei einer Anforderung aus Stufe 0 deren Freigabe als Aufgreifen. Alle Stufen dieser Anforderung bis zur Abnahme laufen auf ihrem Branch. **Hat das Issue schon einen Branch** (Kommentar im Issue): dessen kurzer Name gilt, Branch und Kommentar entfallen — weiter mit „Dokument".

-   **Kurzer Name** aus dem Titel — wenige Wörter, nur `a–z`, `0–9` und Bindestrich (ä → ae, ö → oe, ü → ue, ß → ss), z. B. `timer-ton`; noch nicht vergeben als Branch (`feature/` oder `fix/`, lokal oder beim Hoster nach `git fetch`), unter `_requirements/` (auch `done/`, Dateien mit oder ohne Nummer davor) oder `_requirements/mockups/` — hier und, nach `git fetch`, auf `origin/release-candidate` (`git ls-tree -r --name-only origin/release-candidate _requirements/`; gibt es ihn nicht, entfällt das). Gibt es schon einen Branch mit diesem Namen, aber keinen Kommentar im Issue: fragen. Er ist die Kennung der Anforderung (Branch, Commits, Dateiname); der Agent nennt ihn dem Nutzer gleich zu Beginn.
-   **Branch:** `fix/<kurzer-name>` bei Label `bug`, sonst `feature/<kurzer-name>`; ohne Label fragen. Die Art („Was der Agent macht", Schritt 2) ändert ihn nicht. Angelegt vom aktuellen `main` (`_agent-process/AGENTS.md`, Abschnitt „Git", „Aktueller Stand"), bei einem Fix aus 8b vom aktuellen `release-candidate`. **Direkt nach dem Push** ins Issue kommentieren: „Aufgegriffen auf `<Branch>`".
-   **Dokument** `_requirements/<Nr>-<kurzer-name>.md` (nur, wenn es in keiner Form `*<kurzer-name>.md` schon gibt — ein älteres `<kurzer-name>.md` wird erst in 5b umbenannt) — `<Nr>` ist die Issue-Nummer, mit führenden Nullen auf mindestens drei Stellen (z. B. `042-timer-ton.md`); Branch, Commits und `mockups/` tragen nur den kurzen Namen. Neu nach `_agent-process/anweisungen/vorlagen/anforderung.md`: Titel aus dem Issue-Titel, `Issue #<Nummer>`, Status `new`, Zeile `Track` unverändert lassen (`quick | complete`) — eingetragen erst beim Abschluss. Im Abschnitt „Anliegen" **nur** der Text des Issues, unverändert — nur Sicherheitsdetails abstrakt fassen und Adressen beim Hoster durch `#<Nummer>` ersetzen (`_agent-process/AGENTS.md`, Abschnitt „Grundsätze"); inhaltlich Neues aus den Kommentaren gehört unter „Hintergrund", mit Verweis auf das Issue. **Sofort committen und pushen** (`chore(<kurzer-name>): Anliegen aus Issue #<Nummer>`; bei einer Anforderung aus Stufe 0 zusammen mit `_context/`), ohne Rückfrage — so liegt das Dokument auf seinem Branch.

Geht Lesen oder Kommentieren nicht (Befehl fehlt, keine Rechte, Hoster nicht erreichbar): Der Nutzer gibt Nummer, Titel, Label, Text und ggf. Kommentare; den Kommentar gibt der Agent zum Kopieren aus und arbeitet weiter.

Bevor über Lösungen nachgedacht wird, klärt der Agent den **Rahmen**.

## Start

-   **Zurückgestelltes durchsehen** — nur lesen, wie in `_requirements/deferred/README.md` beschrieben: passende Einträge dem Nutzer nennen; er entscheidet, ob die Anforderung einen übernimmt (dann mit Dateinamen im Dokument).

## Was der Agent macht

1.  **Ist-Stand beschreiben** → Abschnitt „Hintergrund": Wie funktioniert der betroffene Teil heute? Bei Bugs: beobachtetes Fehlverhalten.
2.  **Art bestimmen**: Feature, Bug, Design oder technisch.
3.  **Spielraum vorschlagen** — welche Bereiche dürfen sich ändern:
    -   **Darstellung** — wie es aussieht oder formuliert ist
    -   **Verhalten** — was es aus Nutzersicht tut
    -   **Struktur** — wie es intern gebaut ist, nach außen unverändert
    -   **Schnittstellen/Daten** — Formate, gespeicherte Daten, APIs

    Alles, was **nicht** angekreuzt ist, bleibt unverändert. **Der Nutzer entscheidet** den Spielraum.

    **So fragen:** nicht abstrakt („Welcher Spielraum?"), sondern
    1.  in ein, zwei Sätzen erklären, wofür der Spielraum da ist — er legt fest, was sich durch die Anforderung ändern darf, und schützt alles andere vor ungewollten Änderungen (z. B. dass ein Redesign nicht still das Verhalten ändert),
    2.  einen **konkreten Vorschlag** für genau dieses Anliegen machen, je Bereich mit kurzer Begründung (z. B. „Verhalten: ja — die Funktion ist neu"; „Schnittstellen/Daten: ja — es wird lokal gespeichert"),
    3.  dann um Bestätigung oder Korrektur bitten.

    Bei einem **neuen Projekt** ohne bestehenden Stand gilt meist alles als änderbar — dann das kurz sagen statt vier Einzelfragen zu stellen, und alle Bereiche ankreuzen.
4.  **Offene Fragen sammeln** — als Liste, noch ohne Antworten.
5.  **Weg vorschlagen**:
    -   **Design** nötig (→ Stufe 3)?
    -   **Track:** `quick`, wenn alle vier Punkte zutreffen, sonst `complete` — je Punkt mit kurzer Begründung:
        1.  keine offene Frage (Liste aus Schritt 4 leer),
        2.  nichts Unumkehrbares (gespeicherte Daten, Schnittstellen, Auslieferung),
        3.  klein (wenige Dateien; Plan und Umsetzung passen in einen Schritt),
        4.  kein Design.
    -   Bei einem Bug: siehe „Bugs" unten.

## Was noch nicht hineingehört

Lösungen, Akzeptanzkriterien, Design, Implementierungsdetails.

## Abschluss

Die Klärung ist abgeschlossen, wenn der **Nutzer Spielraum, Weg und Track bestätigt** hat. Offene Fragen dürfen bleiben — sie werden in Stufe 3 bzw. 4 beantwortet; der Track ist dann `complete`.

Vorher fasst der Agent im Gespräch zusammen: Art, Spielraum, Weg (Design ja/nein, Track), offene Fragen — der Nutzer bestätigt. Erst danach trägt der Agent den Track in die Zeile `Track` im Kopf des Dokuments ein.

**Dann committet und pusht der Agent** das Anforderungsdokument auf dem Feature-Branch (`chore(<kurzer-name>): Klärung`), ohne Rückfrage.

## Bugs

Derselbe Prozess, nur kürzer — Track nach den vier Punkten in Schritt 5, bei Bugs oft `quick`:

1.  **Klärung (Stufe 2):** Ursache bestätigen ist Pflicht; Spielraum in der Regel nur „Verhalten" der betroffenen Stelle. Pflichtfrage: **Welche Prüfung hätte diesen Fehler finden müssen?** Diese Prüfung wird mit der Korrektur ergänzt (Test, sauberer Lauf, Prüfpunkt einer Rolle) — sonst kommt derselbe Fehler wieder.
2.  **Design (Stufe 3):** meist nicht nötig — bei einem UI-Bug steht das erwartete Aussehen schon fest (freigegebener Entwurf, Design-System); korrigiert wird dorthin. **Nötig,** wenn die Korrektur eine neue Gestaltungsentscheidung braucht (z. B. ein Fall, den weder Entwurf noch Design-System abdecken) — dann wie in Stufe 3, Entscheidung in der Klärung.
3.  **Refinement (Stufe 4):** kurz — Ursache, erwartetes Verhalten, Kriterium „Test zeigt den Fehler (rot), nach der Korrektur grün".
4.  **Umsetzung (Stufe 5):** auf dem Branch `fix/<kurzer-name>` (ab Stufe 2); zuerst der Test, der den Fehler zeigt.
5.  **QA (Stufe 6):** Umfang laut Tabelle in `_agent-process/skills/ap-requirement-build/qa.md`.
6.  **Abnahme und Release (Stufen 7, 8):** wie sonst; ein Release nur mit Bugs erhöht die Patch-Version (z. B. `v0.1.1`).
