---
name: ap-guideline-ui
description: UI-Richtlinie des Agent-Prozesses (`_agent-process`) – Design-System als Richtlinie, nur Tokens, keine Inline-Styles, Prüflauf, Umgang mit Lücken und was ins Design-System gehört. Nutzen bei jeder Arbeit an Dateien unter den UI-Pfaden aus `_context/projekt.md` (Entwurf, Umsetzung, Prüfung). Nicht für Logik ohne Oberfläche.
---

# UI-Richtlinie

-   **UI-Arbeit:** jede Änderung an Dateien unter den UI-Pfaden aus `_context/projekt.md`.
-   UI-Pfade fehlen oder nur Platzhalter: jede Änderung an der Oberfläche zählt (Markup, Stylesheets, Komponenten); Agent schlägt UI-Pfade vor, trägt sie nach Zustimmung ein.

Für einheitliches Aussehen gilt bei **jeder** UI-Arbeit, mit oder ohne Stufe 3:

-   **Design-System ist die Richtlinie:** UI nur mit seinen Tokens und Komponenten; seine README-Regeln gelten.
-   **Keine festen Werte** für Farben, Maße, Abstände, Radien, Schriftgrößen im App-Code; nur Tokens.
-   **Keine Inline-Styles:** Gestaltung nur in Stylesheets, damit prüfbar.
-   **Prüflauf:** Prüf-Konfiguration im Projekt als `.stylelintrc.json` (von Init angelegt, Erklärung in `_agent-process/init/pruefung/README.md`); läuft mit den Tests (Container und CI). **Ausnahme** nur mit Markierung an der Stelle (mit Grund) und Eintrag in `_context/design.md`.
-   **Fehlt etwas im Design-System** (Komponente, Wert, Muster): in `_context/design.md` unter „Lokal umgesetzt — gehört ins Design-System" eintragen; vorerst lokal mit Tokens umsetzen; als Idee für das Design-System vermerken.
-   **Design-System im Projekt nie bearbeiten.**

## Was ins Design-System gehört

-   **Faustregel:** Würde ein zweites Projekt es auch brauchen? Ja → Design-System (Tokens, Komponenten, allgemeine Muster, Vorlagen-Seiten). Nein → Projekt (konkrete Screens, Texte, Zuordnungen).
-   **In sich geschlossene Module** (z. B. Intervall-Timer) **als Ganzes** ins Design-System: als Vorlage mit allen Zuständen, nicht nur Einzelteile; Bausteine bleiben darunter erhalten.
-   **Aussehen ja, Logik nein:** Design-System zeigt Aussehen, Zustände und wie sie wechseln (als Beschreibung). Logik (Berechnung, Abläufe, Speichern, Geräte-Funktionen) gehört in die App; teilen mehrere Apps sie: eigenes Modul-Repo.
-   **App-Spezifisches bleibt im Projekt:** Entwürfe, Texte, Zuordnungen (z. B. welcher Ton was bedeutet) in `_context/design.md`, nicht im Design-System.
