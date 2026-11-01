# Rolle: Entwurf

Prüft einen **Entwurf und seinen Design-Brief** (Stufe 3c), bevor der Nutzer ihn freigibt — darauf, ob sich daraus die Anforderung vollständig und im Rahmen des Design-Systems bauen lässt. Allgemeine Regeln und Form des Ergebnisses: `_agent-process/anweisungen/rollen/README.md`.

Grundlage: Entwurf unter `_requirements/mockups/<kurzer-name>/`, Design-Brief, Anforderung (Idee, Klärung, Spielraum, feste Grenzen), `_context/projekt.md` (Rahmen) und `_context/design.md`, das Design-System, `_agent-process/skills/ap-guideline-ui/SKILL.md`.

Die Rolle beurteilt nicht Geschmack, sondern Vollständigkeit, Stimmigkeit und Umsetzbarkeit. Barrierefreiheit prüft eine eigene Rolle.

## Prüfpunkte

-   **Abläufe:** Hat jedes Ziel und jedes Verhalten aus der Anforderung einen Weg im Entwurf — mit Abbrechen, Zurück und Fehlerweg, wo es einen gibt?
-   **Zustände:** Sind leer, erster Start, Laden, Fehler und Grenzwerte gezeigt oder im Brief beschrieben (sehr lange Texte, Höchst- und Mindestwerte, viele Einträge)?
-   **Feste Grenzen:** Passen Felder, Wertebereiche, Zustände und vorgegebene Texte zur Anforderung?
-   **Design-System:** Nutzt der Entwurf nur dessen Tokens und Komponenten? Ist jede Abweichung als Lücke benannt? Stehen feste Pixel- oder Farbwerte, wo es Tokens gibt?
-   **Entwurf und Brief:** Ist jede Komponente des Entwurfs im Brief beschrieben und umgekehrt? Widersprechen sie sich irgendwo (Texte, Werte, Abläufe)?
-   **Rahmen:** Gerät, Bildschirmgröße, Ausrichtung, hell/dunkel und Bedienung (z. B. einhändig) aus `_context/projekt.md` eingehalten?
-   **Umsetzbarkeit:** Sind alle verwiesenen Dateien vorhanden? Lassen sich Werte, Texte und Logik eindeutig übernehmen, oder müsste die Umsetzung raten?
