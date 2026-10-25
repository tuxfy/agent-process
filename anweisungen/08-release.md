# Stufe 8: Release

Bringt den Stand von `next` — eine oder mehrere abgenommene Anforderungen — live. **Wann** released wird, entscheidet der Nutzer; **was** mitkommt, hat er schon entschieden: alles, was er nach `next` zusammengeführt hat (siehe `_agent-process/anweisungen/07-abnahme.md`, 7c). Die **Version** wird erst jetzt bestimmt, aus dem Inhalt. Ein Release hat ein eigenes Dokument `_releases/<version>.md`. Auslieferung: `_context/projekt.md`.

**Grundsatz:** Was live ist, zeigt Git — der Tag `v<version>` und das Release-Dokument, das mit ihm nach `main` kam. Es gibt keinen Status „live" in Dokumenten und nach dem Tag keinen Commit mehr.

| Schritt | Wer | Ergebnis |
|---|---|---|
| 8a Inhalt und Version | Agent | Inhalt und Version nach festen Regeln, Release-Dokument auf `next` |
| 8b Gesamtprüfung | Agent | alle Prüfungen grün auf `next`, Release-Dokument fertig, Pull Request nach `main`, **CI grün** |
| 8c Ausliefern | Nutzer | Pull Request als Merge-Commit zusammengeführt — **das ist die Freigabe**; Tag durch die CI (sonst durch den Nutzer) |
| 8d Nachprüfen | CI + Agent + Nutzer | automatischer Test des ausgelieferten Stands, Gerät durch den Nutzer |

## 8a: Inhalt und Version

-   **Start:** Der Nutzer sagt „release" — wann, entscheidet er.
-   **Inhalt:** alle Anforderungen, die seit dem letzten Tag nach `next` zusammengeführt wurden (laut Git-Verlauf; ihre Dokumente liegen in `_requirements/done/`).
-   **Ausnahme — soll eine davon doch nicht mit:** der Agent nimmt sie per Revert-Commit auf `next` wieder heraus (nach Rückfrage); sie kommt mit einem späteren Release. Der Regelfall ist, sie gar nicht erst zusammenzuführen.
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
-   **Der Agent legt die Version nach der Tabelle fest** und nennt dem Nutzer Inhalt, Version und Begründung (je Stufe die ausschlaggebenden Commits) — ohne auf Bestätigung zu warten. **Er fragt nur,** wenn die Gegenprobe nicht stimmt, der Sprung auf 1.0.0 in Frage kommt oder `next` nur `chore`, `test` oder `refactor` enthält.
-   Dann legt der Agent `_releases/<version>.md` nach `_agent-process/anweisungen/vorlagen/release.md` auf `next` an — Inhalt mit relativen Links auf die Anforderungen in `_requirements/done/` —, committet und pusht.

## 8b: Gesamtprüfung

Die Anforderungen sind einzeln geprüft — hier wird geprüft, ob sie **zusammen** funktionieren:

-   Alle Tests, der Prüflauf, die automatischen Prüfungen aus Stufe 6 und der saubere Lauf auf `next`.
-   Kurzer Klicktest über alle enthaltenen Anforderungen (Rolle Klicktester, nur die Hauptwege) — dem Klicktester Version und Liste der Anforderungen nennen.
-   Ergebnis ins Release-Dokument; damit ist es **fertig** — committen, pushen, danach wird es nicht mehr geändert. Das Ergebnis der CI steht im Pull Request, nicht im Dokument.
-   Dann eröffnet der Agent den **Pull Request von `next` nach `main`** (Titel z. B. `chore(release): v<version>`); die CI läuft dort. **Ohne grüne CI kein Zusammenführen und kein Tag.** Dem Nutzer sagt er: Pull Request `#<Nummer>`, CI grün, bereit zum Zusammenführen.
-   Befunde → betroffene Anforderung über einen neuen Bug bzw. Fix-Branch nach `next` korrigieren (das abgenommene Dokument bleibt eingefroren); danach 8b erneut.

## 8c: Ausliefern

-   **Der Nutzer führt den Pull Request** nach `main` zusammen — **als Merge-Commit, nicht per „Squash"**, damit `next` und `main` denselben Verlauf behalten. Das Zusammenführen ist die Freigabe des Releases; eine eigene Freigabe davor gibt es nicht.
-   **Tag:** Hat das Projekt den automatischen Tag eingerichtet (Stufe 0), setzt die CI danach `v<version>` und die Auslieferung startet. Sonst gibt der Agent dem Nutzer die Befehle fertig aus (mit der Version eingesetzt) — Tags lassen sich beim Hoster nicht über die Oberfläche setzen:

    ```
    git switch main
    git pull --ff-only
    git tag -a v<version> -m "Release v<version>"
    git push origin v<version>
    ```
-   Ausgeliefert wird nach `_context/projekt.md` bzw. dem How-to in `_context/` (z. B. automatisch beim Tag).
-   Danach wechselt der Agent auf `main` und holt den Stand (`git switch main`, `git pull --ff-only`).

## 8d: Nachprüfen

-   Kurzer Test des ausgelieferten Stands: Lief die Auslieferung durch, startet die App, funktionieren die Hauptwege — automatisch durch die CI, wenn eingerichtet (Stufe 0), sonst durch den Agenten. Was nur am Gerät geht, prüft der Nutzer. Der Agent sagt dem Nutzer das Ergebnis.
-   **Alles in Ordnung:** nichts mehr zu tun — das Release ist abgeschlossen, der nächste Durchlauf beginnt auf dem aktuellen `main`.
-   **Geht etwas schief** (auch: Auslieferung bricht ab): zurückrollen wie im Release-Dokument beschrieben; der Tag wird nicht wiederverwendet; Befund als Bug ins Backlog, Korrektur im nächsten Patch-Release. Dessen Release-Dokument vermerkt: „ersetzt `v<version>` (fehlgeschlagen)". Das Dokument des fehlgeschlagenen Releases bleibt unverändert.

## Abkürzung

Ist im Projekt festgelegt, dass Zusammenführen bereits ausliefert (z. B. „jeder Stand auf `main` geht live"), gibt es kein `next`: Der Pull Request der Anforderung geht direkt nach `main`; der Nutzer führt ihn nach der Abnahme zusammen; Stufe 8 besteht dann nur aus 8b (auf dem Feature-Branch) und 8d, ein Release-Dokument entfällt.
