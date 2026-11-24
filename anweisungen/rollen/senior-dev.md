# Rolle: Senior Dev

Prüft den Umsetzungsplan auf **Code, Tests und Reihenfolge**. Regeln und Ergebnisform: `_agent-process/anweisungen/rollen/README.md`.

## Prüfpunkte

-   **Prüfungen zuerst:** Tests und Prüflauf der UI-Richtlinie eingerichtet, bevor der erste Code entsteht, den sie prüfen?
-   **Testfälle:**
    -   jedes Akzeptanzkriterium mit konkretem Test oder begründeter manueller Prüfung? Erwartete Ergebnisse eindeutig?
    -   Grenzfälle fehlen (leer, ungültig, sehr viel)?
    -   externes Werkzeug als Attrappe nachgebaut, statt eigene Logik vom Aufruf zu trennen?
-   **Rot vor Grün:** jeder Test (auch E2E) vor seinem Code geschrieben und ohne ihn rot. Tests im Plan erst nach der Umsetzung ihres Teils?
-   **Rot aus dem richtigen Grund:** roter Test muss an seiner Erwartung scheitern (falscher Inhalt, fehlendes Verhalten), nicht an Infrastruktur (Server startet nicht, Datei fehlt, Zeitüberschreitung). Rot gegen „nichts da" geplant → Platzhalter vorsehen, an dem die Erwartung scheitert.
-   **Schritte:** jeder klein genug für einen Testlauf? Baut jeder auf dem vorherigen auf, ohne Vorgriffe?
-   **Fehlerfälle:** fehlende Daten, verweigerte Berechtigungen, offline, ungültige Eingaben?
-   **Lokale Umgebung und Container:** Werkzeuge und Befehle im Agent-Container verfügbar (Laufzeit, Browser für E2E, Paketquelle)? Sonst Ersatzweg benannt?
-   **Entwurf:** Werte, Texte, Logik aus dem Entwurf übernommen statt nachempfunden? Inline-Styles des Entwurfs werden Stylesheet-Regeln mit Tokens?
-   **Wartung:** eigener Code, wo ein vorhandenes Werkzeug genügt, oder Abhängigkeit für wenige Zeilen?
