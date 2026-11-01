# Stufe 8c–8d: Ausliefern und Nachprüfen

## 8c: Ausliefern

-   **Der Nutzer führt den Pull Request** nach `main` zusammen — **als Merge-Commit, nicht per „Squash"**, damit `release-candidate` und `main` denselben Verlauf behalten. Das Zusammenführen ist die Freigabe des Releases; eine eigene Freigabe davor gibt es nicht.
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
