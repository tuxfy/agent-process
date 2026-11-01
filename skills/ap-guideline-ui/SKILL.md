---
name: ap-guideline-ui
description: UI-Richtlinie des Agent-Prozesses (`_agent-process`) – Design-System als Richtlinie, nur Tokens, keine Inline-Styles, Prüflauf, Umgang mit Lücken und was ins Design-System gehört. Nutzen bei jeder Arbeit an Dateien unter den UI-Pfaden aus `_context/projekt.md` (Entwurf, Umsetzung, Prüfung). Nicht für Logik ohne Oberfläche.
---

# UI-Richtlinie

UI-Arbeit ist jede Änderung an Dateien unter den UI-Pfaden aus `_context/projekt.md`. Fehlen dort die UI-Pfade oder steht nur der Platzhalter da, zählt jede Änderung an der Oberfläche (Markup, Stylesheets, Komponenten); der Agent schlägt die UI-Pfade vor und trägt sie nach Zustimmung ein.

Damit die App einheitlich aussieht, gilt bei **jeder** UI-Arbeit — mit oder ohne Stufe 3:

-   **Das Design-System ist die Richtlinie.** UI nur mit seinen Tokens und Komponenten; seine README-Regeln gelten.
-   **Keine festen Werte** für Farben, Maße, Abstände, Radien oder Schriftgrößen im App-Code — nur Tokens.
-   **Keine Inline-Styles** — Gestaltung steht nur in Stylesheets, damit sie prüfbar bleibt.
-   **Prüflauf:** Die Prüf-Konfiguration liegt im Projekt als `.stylelintrc.json` (von Init angelegt, Erklärung in `_agent-process/init/pruefung/README.md`) und läuft mit den Tests (im Container und in der CI). **Ausnahme** nur mit Markierung an der Stelle (mit Grund) und Eintrag in `_context/design.md`.
-   **Fehlt etwas im Design-System** (Komponente, Wert, Muster): in `_context/design.md` unter „Lokal umgesetzt — gehört ins Design-System" eintragen, vorerst lokal mit Tokens umsetzen, als Idee für das Design-System vermerken.
-   **Das Design-System wird im Projekt nie bearbeitet.**

## Was ins Design-System gehört

-   **Faustregel — was gehört wohin:** Würde ein zweites Projekt es auch brauchen? Ja → Design-System (Tokens, Komponenten, allgemeine Muster, Vorlagen-Seiten). Nein → Projekt (konkrete Screens, Texte, Zuordnungen).
-   **In sich geschlossene Module** (z. B. ein Intervall-Timer) kommen **als Ganzes** ins Design-System — als Vorlage mit allen Zuständen, nicht nur in Einzelteilen; die Bausteine bleiben darunter erhalten.
-   **Aussehen ja, Logik nein:** Das Design-System zeigt, wie etwas aussieht, welche Zustände es gibt und wie sie wechseln (als Beschreibung). Logik (Berechnung, Abläufe, Speichern, Geräte-Funktionen) gehört in die App — oder, wenn mehrere Apps sie teilen, in ein eigenes Modul-Repo.
-   **App-Spezifisches bleibt im Projekt:** Entwürfe, Texte und Zuordnungen (z. B. welcher Ton was bedeutet) stehen in `_context/design.md`, nicht im Design-System.
