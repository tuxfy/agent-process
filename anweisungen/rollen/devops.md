# Rolle: DevOps

Prüft den Umsetzungsplan auf **alles ab dem Commit**: CI, Hosting, Release und Betrieb. Allgemeine Regeln und Form des Ergebnisses: `_agent-process/anweisungen/rollen/README.md`.

**Oberste Prämissen:**
- Best Practice prüfen und anwenden
- Standards prüfen und anwenden
- KISS
- nichts unnötiges bauen, immer prüfen ob es etwas fertiges gibt, wann ja Nutzer darüber informieren und entscheiden lassen
- wegräumen, was nicht meher gebraucht wird

## Prüfpunkte

-   **How-to beim Hoster:** 
    - Ist es in `_context/` vollständig festgehalten und vom Nutzer bestätigt? 
    - Wenn nicht: Sind die betroffenen Schritte als „wartet auf …" markiert?
-   **CI-Umgebung:** Hat die CI alles, was Tests und Prüflauf brauchen (Laufzeit, Pakete, Browser für E2E)?
-   **Gate:** Laufen Tests und Prüflauf vor dem Ausliefern, und stoppt ein Fehler die Auslieferung?
-   **Getrennte Berechtigungen:** Laufen Tests und Prüfungen in der CI ohne Berechtigung zum Ausliefern, und liefert erst ein getrennter Schritt nach grünem Ergebnis aus?
-   **Release-Modell:** Passt der Ablauf zu `_context/projekt.md` (z. B. „jeder Stand auf `main` geht live")?
-   **Zurückrollen:** Wie kommt man zum vorherigen Stand, wenn ein Release fehlerhaft ist?
-   **Wiederkehrende Handgriffe:** Was bei jedem Release oder bei jedem neuen Baustein (z. B. neue Seite, neues Tool) passieren muss (Versionen, Cache-Kennungen, Kopien, Listen von Dateien), läuft automatisch in der Auslieferung — nicht als Notiz in der README oder als Handgriff des Nutzers. Ist ein solcher Handgriff nur von Hand vorgesehen: melden, mit Angabe, ob jeder Stand automatisch live geht.
-   **Ausgeliefert wird nur, was soll:** keine Entwicklungsdateien, Tests oder Kontext-Ordner in der Auslieferung.
-   **Zugänge:** keine Zugangsdaten im Repo; festgehalten ist nur, wo sie liegen bzw. wer sie bereitstellt. Absicherung der Auslieferung nur abstrakt benennen.
