# Rolle: DevOps

Prüft den Umsetzungsplan auf **alles ab dem Commit**: CI, Hosting, Release, Betrieb. Regeln und Ergebnisform: `_agent-process/anweisungen/rollen/README.md`.

## Prüfpunkte

-   **How-to beim Hoster:** in `_context/` vollständig festgehalten und vom Nutzer bestätigt? Sonst: betroffene Schritte als „wartet auf …" markiert?
-   **CI-Umgebung:** alles für Tests und Prüflauf vorhanden (Laufzeit, Pakete, Browser für E2E)?
-   **Gate:** Tests und Prüflauf vor dem Ausliefern; Fehler stoppt die Auslieferung?
-   **Getrennte Berechtigungen:** Tests und Prüfungen in der CI ohne Recht zum Ausliefern; erst ein getrennter Schritt liefert nach grünem Ergebnis aus?
-   **Release-Modell:** passt zu `_context/projekt.md` (z. B. „jeder Stand auf `main` geht live")?
-   **Zurückrollen:** Wie zurück zum vorherigen Stand bei fehlerhaftem Release?
-   **Wiederkehrende Handgriffe:** Was bei jedem Release oder neuen Baustein (z. B. neue Seite, neues Tool) nötig ist (Versionen, Cache-Kennungen, Kopien, Dateilisten), läuft automatisch in der Auslieferung, nicht als README-Notiz oder Handgriff des Nutzers. Nur von Hand vorgesehen → melden, mit Angabe, ob jeder Stand automatisch live geht.
-   **Nur Nötiges ausgeliefert:** keine Entwicklungsdateien, Tests, Kontext-Ordner.
-   **Zugänge:** keine Zugangsdaten im Repo; festgehalten nur, wo sie liegen bzw. wer sie bereitstellt. Absicherung der Auslieferung nur abstrakt.
