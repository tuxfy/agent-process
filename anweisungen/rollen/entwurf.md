# Rolle: Entwurf

Prüft **Entwurf und Design-Brief** (Stufe 3c) vor der Freigabe durch den Nutzer: Lässt sich daraus die Anforderung vollständig und im Rahmen des Design-Systems bauen? Regeln und Ergebnisform: `_agent-process/anweisungen/rollen/README.md`.

-   **Grundlage:** Entwurf unter `_requirements/mockups/<kurzer-name>/`, Design-Brief, Anforderung (Anliegen, Klärung, Spielraum, feste Grenzen), `_context/projekt.md` (Rahmen), `_context/design.md`, Design-System, `_agent-process/skills/ap-guideline-ui/SKILL.md`.
-   **Nicht:** Geschmack; Barrierefreiheit (eigene Rolle). Nur Vollständigkeit, Stimmigkeit, Umsetzbarkeit.

## Prüfpunkte

-   **Abläufe:** jedes Ziel und Verhalten der Anforderung mit Weg im Entwurf, mit Abbrechen, Zurück und Fehlerweg, wo es einen gibt?
-   **Zustände:** leer, erster Start, Laden, Fehler, Grenzwerte (sehr lange Texte, Höchst- und Mindestwerte, viele Einträge) gezeigt oder im Brief beschrieben?
-   **Feste Grenzen:** Felder, Wertebereiche, Zustände, vorgegebene Texte passen zur Anforderung?
-   **Design-System:** nur dessen Tokens und Komponenten? Jede Abweichung als Lücke benannt? Feste Pixel- oder Farbwerte, wo es Tokens gibt?
-   **Entwurf und Brief:** jede Komponente des Entwurfs im Brief und umgekehrt? Widersprüche (Texte, Werte, Abläufe)?
-   **Rahmen:** Gerät, Bildschirmgröße, Ausrichtung, hell/dunkel, Bedienung (z. B. einhändig) aus `_context/projekt.md` eingehalten?
-   **Umsetzbarkeit:** alle verwiesenen Dateien vorhanden? Werte, Texte, Logik eindeutig übernehmbar, oder müsste die Umsetzung raten?
