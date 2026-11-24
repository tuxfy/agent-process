# Stufe 8c–8d: Ausliefern und Nachprüfen

## 8c: Ausliefern

-   **Nutzer führt den Pull Request nach `main` zusammen,** **als Merge-Commit, nicht per „Squash"** (damit `release-candidate` und `main` denselben Verlauf behalten). Das ist die Freigabe des Releases; keine eigene Freigabe davor.
-   **Tag:**
    -   automatischer Tag eingerichtet (Stufe 0) → CI setzt danach `v<version>`, Auslieferung startet;
    -   sonst gibt der Agent dem Nutzer die Befehle fertig aus (Version eingesetzt), direkt nach dem Zusammenführen auszuführen; Tags lassen sich beim Hoster nicht über die Oberfläche setzen:

    ```
    git fetch origin &&
    git tag -a v<version> -m "Release v<version>" origin/main &&
    git push origin v<version>
    ```
-   Ausgeliefert nach `_context/projekt.md` bzw. dem How-to in `_context/` (z. B. automatisch beim Tag).
-   Danach auf `main` wechseln und Stand holen (`git switch main`, `git pull --ff-only`).

## 8d: Nachprüfen

-   **Kurzer Test des ausgelieferten Stands:** Auslieferung durchgelaufen, App startet, Hauptwege funktionieren; automatisch durch die CI, wenn eingerichtet (Stufe 0), sonst durch den Agenten. Nur am Gerät Prüfbares prüft der Nutzer. Ergebnis dem Nutzer sagen.
-   **Alles in Ordnung:** nichts mehr zu tun; Release abgeschlossen; nächster Durchlauf beginnt auf dem aktuellen `main`.
-   **Etwas geht schief** (auch: Auslieferung bricht ab):
    -   zurückrollen wie im Release-Dokument beschrieben; Tag nicht wiederverwenden;
    -   Befund als Bug-Issue (Stufe 1), darin die Issues des Releases nennen (`#<Nummer>`, schon geschlossen);
    -   Korrektur im nächsten Patch-Release; dessen Release-Dokument vermerkt: „ersetzt `v<version>` (fehlgeschlagen)";
    -   Dokument des fehlgeschlagenen Releases bleibt unverändert.
