# Stufe 8: Release

Bringt den Stand von `next` — eine oder mehrere abgenommene Anforderungen — live. **Wann** released wird, entscheidet der Nutzer; die **Version** wird erst jetzt bestimmt, aus dem Inhalt. Ein Release hat ein eigenes Dokument `releases/<version>.md`. Auslieferung: `_kontext/projekt.md`.

| Schritt | Wer | Ergebnis |
|---|---|---|
| 8a Umfang und Version | Agent schlägt vor, Nutzer bestätigt | Inhalt, Version, Release-Dokument auf `next` |
| 8b Gesamtprüfung | Agent | alle Prüfungen grün auf `next`, Pull Request nach `main`, **CI grün** |
| 8c Freigabe | Nutzer | Release freigegeben |
| 8d Ausliefern | Nutzer | Pull Request zusammengeführt, Tag `v<version>` gesetzt und gepusht |
| 8e Nachprüfen | Agent + Nutzer | kurzer Test des ausgelieferten Stands |
| 8f Abschluss | Agent | Anforderungen `done`, Release-Dokument abgeschlossen |

## 8a: Umfang und Version

-   **Inhalt:** alle Anforderungen, die seit dem letzten Tag nach `next` zusammengeführt wurden (Status `accepted`).
-   **Soll eine davon doch nicht mit:** der Nutzer entscheidet; der Agent nimmt sie per Revert-Commit auf `next` wieder heraus (nach Rückfrage) — die Anforderung bleibt `accepted` und kommt mit einem späteren Release.
-   **Version bestimmen** — Grundlage sind die Commits auf `next` seit dem letzten Tag `v<x.y.z>` (bei Zusammenführen per „Squash": die Titel der Pull Requests):

    | Enthalten | ab Version 1.0.0 | vor 1.0.0 |
    |---|---|---|
    | mindestens eine Änderung mit `!` (bricht Bestehendes) | Major: `x+1.0.0` | Minor: `0.y+1.0` |
    | mindestens ein `feat` | Minor: `x.y+1.0` | Minor: `0.y+1.0` |
    | sonst (`fix`, `refactor`, `test`, `chore`, `design`) | Patch: `x.y.z+1` | Patch: `0.y.z+1` |

    -   Es gilt die **höchste** Stufe. Erstes Release ohne vorherigen Tag: `0.1.0`.
    -   **Gegenprobe** mit den Anforderungen: Ist eine Anforderung ein Feature, aber kein `feat`-Commit dabei (oder ein Bug mit `feat`)? Dann stimmen die Commit-Typen nicht — dem Nutzer melden, nicht still korrigieren.
    -   Den Sprung auf **1.0.0** entscheidet nur der Nutzer.
    -   Enthält `next` seit dem letzten Tag nur `chore`, `test` oder `refactor`: dem Nutzer vorschlagen, ob sich ein Release überhaupt lohnt.
-   Der Agent schlägt Version und Begründung vor (je Stufe die ausschlaggebenden Commits), **der Nutzer bestätigt**.
-   Dann legt der Agent `releases/<version>.md` nach `_anweisungen/vorlagen/release.md` auf `next` an, committet und pusht.

## 8b: Gesamtprüfung

Die Anforderungen sind einzeln geprüft — hier wird geprüft, ob sie **zusammen** funktionieren:

-   Alle Tests, der Prüflauf, die automatischen Prüfungen aus Stufe 6 und der saubere Lauf auf `next`.
-   Der Agent eröffnet den **Pull Request von `next` nach `main`** (Titel z. B. `chore(release): v<version>`); die CI läuft dort. **Ohne grüne CI kein Zusammenführen und kein Tag.**
-   Kurzer Klicktest über alle enthaltenen Anforderungen (Rolle Klicktester, nur die Hauptwege).
-   Ergebnis im Release-Dokument. Befunde → betroffene Anforderung zurück in Stufe 5; neue Abnahme nur für deren Änderung.

## 8c: Freigabe

-   Der Nutzer gibt das Release ausdrücklich frei.

## 8d: Ausliefern

-   **Der Nutzer führt den Pull Request** nach `main` zusammen, setzt auf dem neuen Stand von `main` den Tag `v<version>` und pusht ihn; erst damit wird ausgeliefert.
-   Ausgeliefert wird nach `_kontext/projekt.md` bzw. dem How-to in `_kontext/` (z. B. automatisch beim Push auf `main`).

## 8e: Nachprüfen

-   Kurzer Test des ausgelieferten Stands: startet die App, funktionieren die Hauptwege.
-   Geht etwas schief (auch: Auslieferung bricht ab): zurückrollen wie im Release-Dokument beschrieben; Release-Status **`failed`**, der Tag wird nicht wiederverwendet; Befund als Bug ins Backlog, Korrektur im nächsten Patch-Release. Die enthaltenen Anforderungen bleiben `accepted`.

## 8f: Abschluss

-   Auf dem Branch `release/<version>-abschluss` (von `main`): alle enthaltenen Anforderungen Status `done`, Dokument nach `anforderungen/done/`.
-   Release-Dokument: Status `released`, Datum — **erst**, wenn die Nachprüfung (8e) den ausgelieferten Stand bestätigt hat.
-   Optional: kurzer Rückblick zum Release (wie 7d).
-   Pushen, Pull Request eröffnen; der Nutzer führt zusammen.
-   Danach: `git switch main`, `git pull --ff-only` — der Durchlauf ist abgeschlossen, der nächste beginnt auf dem aktuellen `main`.

## Abkürzung

Ist im Projekt festgelegt, dass Zusammenführen bereits ausliefert (z. B. „jeder Stand auf `main` geht live"), gibt es kein `next`: Der Pull Request der Anforderung geht direkt nach `main`; der Nutzer führt ihn nach der Abnahme zusammen; Stufe 8 besteht dann nur aus 8b (auf dem Feature-Branch), 8e und 8f, ein Release-Dokument entfällt.
