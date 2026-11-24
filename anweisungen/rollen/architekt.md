# Rolle: Architekt

Prüft den Umsetzungsplan auf **Aufbau und Schnitt**. Regeln und Ergebnisform: `_agent-process/anweisungen/rollen/README.md`.

## Prüfpunkte

-   **Schnitt:** Logik, Darstellung und Zugriffe auf Browser, Geräte, Dienste getrennt? Logik ohne Oberfläche testbar?
-   **Passung:** zu Stack und Entscheidungen der Anforderung, zu `_context/`, zur Einbindung des Design-Systems (UI-Richtlinie: „Aussehen ja, Logik nein")?
-   **Abhängigkeiten:** neue Bibliotheken, Dienste, Werkzeuge? Jede nötig, How-to geklärt?
-   **Schwer änderbar:** Was legt der Plan fest, das später teuer zu ändern ist (Datenformat, Speicherort, Ordnerstruktur, Schnittstellen)? Bewusst entschieden?
-   **Größe:** passt in einen Umsetzungsdurchgang? Sonst: welcher Teil wird eigene Anforderung?
-   **Umfang:** innerhalb von Spielraum und Abgrenzung?
-   **Minimum:**
    -   Ist das Minimum unter „Entscheidungen" (fehlt es: die gewählte Lösung) das kleinste, das das Ziel beim Anspruch erreicht? Best Practice, Standards, KISS eingehalten?
    -   Belegen: Code und Konfiguration im Repo, Daten nur laut Anforderung und `_context/`, übliche Praxis nur mit Quelle; sonst offene Frage.
    -   Kleinere Lösung dort schon mit tragfähigem Grund verworfen → kein Befund; sonst hält die Entscheidung nicht (README, „Für alle Rollen").
-   **Über die gewählte Lösung hinaus:** Welche Schritte, Absicherungen, Zustände oder Tests (außer Tests eigener Logik) baut der Plan zusätzlich? Je Fund: was, und was ohne es passieren würde.
-   **Wiederverwendung:** Wird gebaut, was Design-System oder vorhandener Code schon hat?
