-   **Title** Kurzer Titel
-   **Status** idea | bug | new | refined | in progress | qa | review | accepted

# Idee

*(unverändert aus der Idee übernommen)*

# Hintergrund

Ist-Stand: Wie funktioniert der betroffene Teil heute? Bei Bugs: beobachtetes Fehlverhalten.

# Einordnung

-   **Art:** Feature | Bug | Design | technisch
-   **Spielraum** (nur Angekreuztes darf sich ändern):
    -   [ ] Darstellung
    -   [ ] Verhalten
    -   [ ] Struktur
    -   [ ] Schnittstellen/Daten
-   **Weg:** Design nötig? ja/nein · Ursache bestätigen? ja/nein/entfällt

# Offene Fragen

-   ...

# Design-Brief

*Nur wenn Design nötig. Entsteht mit dem Entwurf extern und wird in 3c unverändert übernommen (siehe `_agent-process/anweisungen/03-design.md`).*

-   **Ziel:**
-   **Aufbau und Zustände:** Screens, Bereiche, Zustände und Übergänge
-   **Abläufe:** was der Nutzer wo tut
-   **Texte:**
-   **Design-System:** genutzte Komponenten und Tokens · Zuordnungen aus `_context/design.md`
-   **Rahmen:**
-   **Lücken:** was das Design-System nicht hat
-   **Entwurf:** `_requirements/mockups/<kurzer-name>/`

# Entscheidungen

-   ...

# Verhalten

Was der Nutzer sieht und tut.

# Akzeptanzkriterien

| Kriterium | Prüfung |
|---|---|
| ... | Unit / E2E / manuell |
| Test für das abzusichernde Verhalten geschrieben — ohne die Änderung rot | Testlauf |
| Nach der Umsetzung laufen alle Tests grün | Testlauf |
| UI-Richtlinie eingehalten | Prüflauf / Review |
| *(bei Design)* Entwurf umgesetzt, Werte und Logik aus der Quelle übernommen | manuell |
| *(nur wenn sich Setup, Konfiguration oder Bedienung ändern)* `README.md` ergänzt | Review |

# Abgrenzung

-   ...

# Technische Notizen

*Optional, nicht bindend.*

# Umsetzungsplan

*Vom Agenten in Stufe 5 (5a) geschrieben, vom Nutzer freigegeben.*

1.  **Schritte:**
2.  **Betroffene Dateien:**
3.  **Testfälle:**
4.  **Entwurf → Code** *(bei Design)*:
5.  **Externe Abhängigkeiten** (How-to wo?):
6.  **Annahmen und Risiken:**
7.  **Nicht angefasst:**

# Testnachweis

*Vom Agenten in Stufe 5 ergänzt.*

-   **Rot** (vor der Änderung): `<Befehl>` — <n> bestanden / <m> fehlgeschlagen; rot: `<Testname>`, …
-   **Grün** (nach der Änderung): `<Befehl>` — <n> bestanden / 0 fehlgeschlagen
-   **UI-Richtlinie:** `<Befehl>` — 0 Befunde; Ausnahmen: <keine | Liste> *(lief der Prüflauf nicht: Grund und manuelle Prüfung)*

# QA

*Vom Agenten in Stufe 6 ergänzt.*

-   **Automatisch:** je Prüfung Befehl und Ergebnis; nicht Eingerichtetes nennen
-   **Geprüft durch:** <Rollen>
-   **Befunde:** je Befund kurz, was damit passiert ist

# Abnahme

*In Stufe 7 ergänzt.*

-   **Abgenommen am:** <Datum> — <was geprüft wurde>
