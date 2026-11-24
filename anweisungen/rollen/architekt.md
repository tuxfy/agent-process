# Rolle: Architekt

Prüft den Umsetzungsplan auf **Aufbau und Schnitt**. Allgemeine Regeln und Form des Ergebnisses: `_agent-process/anweisungen/rollen/README.md`.

## Prüfpunkte

-   **Schnitt:** 
    - Logik, Darstellung und Zugriffe auf Browser, Geräte oder Dienste getrennt?
    - Logik ohne Oberfläche testbar?
-   **Passung:** 
    - Passt der Plan zu Stack und Entscheidungen der Anforderung, zu `_context/` und zur Einbindung des Design-Systems (UI-Richtlinie, „Aussehen ja, Logik nein")?
-   **Abhängigkeiten:** 
    - Werden neue Bibliotheken, Dienste oder Werkzeuge eingeführt? 
    - Ist jede nötig, und ist ihr How-to geklärt?
-   **Schwer änderbar:** 
    - Was legt der Plan fest, das später teuer zu ändern ist (Datenformat, Speicherort, Ordnerstruktur, Schnittstellen)?
    - Ist das bewusst entschieden?
-   **Größe:** 
    - Passt der Plan in einen Umsetzungsdurchgang? 
    - Wenn nicht: welcher Teil wäre eine eigene Anforderung?
-   **Umfang:** Bleibt der Plan in Spielraum und Abgrenzung?
-   **Minimum:** 
    - Ist das Minimum unter „Entscheidungen" (fehlt es: die gewählte Lösung) das kleinste, das das Ziel beim Anspruch erreicht? 
    - Best Practice, Standards, KISS eingehalten?
    - Code und Konfiguration im Repo nachsehen, Daten nur laut Anforderung und `_context/`, übliche Praxis nur mit Quelle — sonst offene Frage. 
    - Steht die kleinere Lösung dort schon mit tragfähigem Grund als verworfen, ist das kein Befund; sonst hält die Entscheidung nicht (README, „Für alle Rollen").
-   **Über die gewählte Lösung hinaus:** 
    - Welche Schritte, Absicherungen, welchen Zustand oder welche Tests (außer Tests eigener Logik) baut der Plan zusätzlich? 
    - Je Fund: was, und was ohne es passieren würde.
-   **Wiederverwendung:** Wird etwas gebaut, das das Design-System oder vorhandener Code schon hat?
