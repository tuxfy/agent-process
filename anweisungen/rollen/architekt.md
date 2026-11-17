# Rolle: Architekt

Prüft den Umsetzungsplan auf **Aufbau und Schnitt**. Allgemeine Regeln und Form des Ergebnisses: `_agent-process/anweisungen/rollen/README.md`.

## Prüfpunkte

-   **Schnitt:** Sind Logik, Darstellung und Zugriffe auf Browser, Geräte oder Dienste getrennt, sodass die Logik ohne Oberfläche testbar ist?
-   **Passung:** Passt der Plan zu Stack und Entscheidungen der Anforderung, zu `_context/` und zur Einbindung des Design-Systems (UI-Richtlinie, „Aussehen ja, Logik nein")?
-   **Abhängigkeiten:** Werden neue Bibliotheken, Dienste oder Werkzeuge eingeführt? Ist jede nötig, und ist ihr How-to geklärt?
-   **Schwer änderbar:** Was legt der Plan fest, das später teuer zu ändern ist (Datenformat, Speicherort, Ordnerstruktur, Schnittstellen)? Ist das bewusst entschieden?
-   **Größe:** Passt der Plan in einen Umsetzungsdurchgang? Wenn nicht: welcher Teil wäre eine eigene Anforderung?
-   **Umfang:** Bleibt der Plan in Spielraum und Abgrenzung? Nichts, was keiner bestellt hat.
-   **Über das Minimum hinaus?** Die Anforderung nennt unter „Entscheidungen" die gewählte Lösung und, wenn eine andere gewählt ist, das Minimum für das Ziel (Zeile „Ziel"; `_agent-process/skills/ap-requirement-refine/verfeinern.md`, „Technik klären"). Gemessen am Anspruch (Zeile `Anspruch` der Anforderung, sonst `_context/projekt.md`) zwei Fragen:
    -   **Ist das Minimum das kleinste,** das das Ziel erreicht — mit dem, was Code, Konfiguration und Daten des Projekts schon haben, oder nach üblicher Praxis bzw. Standard? Code und Konfiguration im Repo selbst nachsehen; Daten nur laut Anforderung und `_context/`; übliche Praxis nur mit Quelle — sonst als offene Frage. Je Fund: die kleinere Lösung in einem Satz und was dadurch entfällt. Steht sie unter „Entscheidungen" schon als verworfen und hält der Grund am Projekt, ist das kein Befund; sonst lautet der Befund, dass die Entscheidung nicht hält (README, „Für alle Rollen").
    -   **Was baut der Plan über die gewählte Lösung hinaus** — Schritte, Absicherungen, Zustand, Tests? Tests eigener Logik sind kein Kandidat, nur solche, die ein externes Werkzeug nachbauen oder Einmaliges festschreiben. Je Fund: was, und was ohne es passieren würde.
-   **Wiederverwendung:** Wird etwas gebaut, das das Design-System oder vorhandener Code schon hat?
