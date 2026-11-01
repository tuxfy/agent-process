# Stufe 2: Klärung

**Beginn:** Greift der Nutzer einen Eintrag auf, legt der Agent den Branch `feature/<kurzer-name>` (bei Bugs `fix/<kurzer-name>`) vom aktuellen `main` an (`_agent-process/AGENTS.md`, Abschnitt „Git", „Aktueller Stand"); alle weiteren Stufen dieser Anforderung bis zur Abnahme laufen dort. Voraussetzung: Der Eintrag ist schon auf `main` (Backlog-Pull-Request zusammengeführt). **Ausnahme:** Fix aus der Gesamtprüfung (8b) — Branch vom aktuellen `release-candidate`, der Bug-Eintrag entsteht dort (`_agent-process/skills/ap-release/gesamtpruefung.md`).

Der Nutzer greift eine Idee auf. Bevor über Lösungen nachgedacht wird, klärt der Agent den **Rahmen**.

## Start

-   Auslöser: Der Nutzer greift eine Idee ausdrücklich auf.
-   Status `idea` bzw. `bug` → `new`. Das Dokument bleibt in `_requirements/backlog/`.
-   Das Dokument wird nach `_agent-process/anweisungen/vorlagen/anforderung.md` erweitert; der Abschnitt „Idee" bleibt unverändert erhalten.
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
    2.  einen **konkreten Vorschlag** für genau diese Idee machen, je Bereich mit kurzer Begründung (z. B. „Verhalten: ja — die Funktion ist neu"; „Schnittstellen/Daten: ja — es wird lokal gespeichert"),
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

Vorher fasst der Agent im Gespräch zusammen: Art, Spielraum, Weg (Design ja/nein, Track), offene Fragen — der Nutzer bestätigt. Den Track trägt der Agent in die Zeile `Track` im Kopf des Dokuments ein.

**Dann committet und pusht der Agent** das Anforderungsdokument auf dem Feature-Branch (`chore(<kurzer-name>): Klärung`), ohne Rückfrage.

## Bugs

Derselbe Prozess, nur kürzer — Track nach den vier Punkten in Schritt 5, bei Bugs oft `quick`:

1.  **Klärung (Stufe 2):** Ursache bestätigen ist Pflicht; Spielraum in der Regel nur „Verhalten" der betroffenen Stelle. Pflichtfrage: **Welche Prüfung hätte diesen Fehler finden müssen?** Diese Prüfung wird mit der Korrektur ergänzt (Test, sauberer Lauf, Prüfpunkt einer Rolle) — sonst kommt derselbe Fehler wieder.
2.  **Design (Stufe 3):** meist nicht nötig — bei einem UI-Bug steht das erwartete Aussehen schon fest (freigegebener Entwurf, Design-System); korrigiert wird dorthin. **Nötig,** wenn die Korrektur eine neue Gestaltungsentscheidung braucht (z. B. ein Fall, den weder Entwurf noch Design-System abdecken) — dann wie in Stufe 3, Entscheidung in der Klärung.
3.  **Refinement (Stufe 4):** kurz — Ursache, erwartetes Verhalten, Kriterium „Test zeigt den Fehler (rot), nach der Korrektur grün".
4.  **Umsetzung (Stufe 5):** auf dem Branch `fix/<kurzer-name>` (ab Stufe 2); zuerst der Test, der den Fehler zeigt.
5.  **QA (Stufe 6):** Umfang laut Tabelle in `_agent-process/skills/ap-requirement-build/qa.md`.
6.  **Abnahme und Release (Stufen 7, 8):** wie sonst; ein Release nur mit Bugs erhöht die Patch-Version (z. B. `v0.1.1`).
