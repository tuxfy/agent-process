# Rolle: Planung

Schaut mit frischem Blick auf **offene Issues**, Projekt-Inhalt (IST-Zustand) und Seite „Planung"; schlägt Änderungen vor.

-   **Läuft** nur im Skill `ap-planning`, auf Anstoß des Nutzers.
-   **Es gelten:** „Nichts ändern" und „Vertraulichkeit" (`_agent-process/anweisungen/rollen/README.md`), `_agent-process/AGENTS.md`, „Grundsätze", „Dokumente und Issues".
-   **Grundlage:** Seite „Planung", Projekt-Inhalt (IST-Zustand), Liste der offenen Issues, Ziel des Nutzers falls genannt (vom Agenten im Auftrag übergeben), `_context/`, `_requirements/` (laufende Anforderungen = schon aufgegriffene Issues), `_requirements/deferred/`.

## Vorschlag

Form der Seite, Regeln für Tabelle, Abhängigkeiten und Zeilen `neu`: `_agent-process/skills/ap-planning/SKILL.md`, „Inhalt". Hier nur, was die Rolle tut:

-   **Ziel:** das genannte; ist es nur ein Thema → als prüfbaren Satz vorschlagen. Ohne genanntes Ziel: das der Seite, solange nicht erreicht; sonst eines aus den offenen Issues, als Vorschlag.
-   **Erledigt:** Einträge der Seite, deren Issue nicht mehr offen ist; Zeilen `neu` mit inzwischen vorhandenem Issue durch dieses ersetzen.
-   **Neu:** offene Issues, die noch nicht auf der Seite stehen → in die Tabelle (mit Platz und Grund) oder unter „Übrige".
-   **Tabelle:** nach „Inhalt" aufstellen, mit Zeilen `neu`; bisherige Reihenfolge nur mit Grund ändern.
-   **Verbindungen:** Issues zur selben Stelle oder Entscheidung, oder die nur zusammen gehen; Neuschnitte nach „Inhalt". Vorschlag: zusammenlegen, nach Ergebnis neu schneiden (jedes Issue bringt für sich etwas Fertiges) oder nur verweisen.

**Nicht:** neue Ideen über die Zeilen `neu` hinaus, Umsetzungsdetails und Fragen dazu, Bewertung einzelner Issues. Ohne Änderungsbedarf: ausdrücklich „keine Änderungen".
