# Rollen für Prüfungen

Unabhängige Prüfer mit frischem Blick. Sie ändern nichts am Projekt. Wann welche Rolle prüft, steht in der jeweiligen Stufe (3c, 5a, 6, 8b) bzw. im Skill. In Claude Code laufen sie als Unteragenten (`.claude/agents/`), sonst als eigene Sitzung je Rolle. Mehrere laufen parallel; der Agent führt die Ergebnisse zusammen. Reviewer, Security und Testwirkung (6b) bekommen den Diff als Datei: Der Agent schreibt ihn vor jedem Lauf neu nach `.qa/diff.txt`, wenn alles committet ist: `git fetch`, dann `git diff origin/<Ziel>...HEAD` — Ziel ist das Ziel des Pull Requests (`release-candidate`; bei der Abkürzung oder solange es `release-candidate` noch nicht gibt: `main`).

**Blick je Rolle:**

-   **Design (3c):** Entwurf (Abläufe, Zustände, Design-System, Brief, Umsetzbarkeit) · Barrierefreiheit (Kontrast, Namen, Fokus, Tippflächen)
-   **Plan:** Architekt (Aufbau, Schnitt, Abhängigkeiten, Größe) · Senior Dev (Code, Tests, Reihenfolge, Fehlerfälle, Umgebung und Container) · DevOps (alles ab dem Commit: CI, Hosting, Release, Betrieb)
-   **Umsetzung:** Reviewer (Code gegen Anforderung, Plan und Entscheidungen) · Security (Sicherheit nach Checkliste) · Testwirkung (würden die Tests Fehler finden?) · Klicktester (die laufende App wie ein Mensch)
-   **Planung** (`ap-planning`, kein Prüfer): Vorschlag zu Ziel, Reihenfolge und Verbindungen der offenen Issues — eigene Grundlage und Form in `planung.md`.

Datei je Rolle: `<rolle>.md` in diesem Ordner.

## Für alle Rollen

-   **Lesen:** die Anforderung (inkl. `# Umsetzungsplan`), `_context/`, `AGENTS.md` des Projekts und `_agent-process/AGENTS.md`, die betroffenen `_agent-process/anweisungen/`; bei UI-Arbeit `_agent-process/skills/ap-guideline-ui/SKILL.md`; bei Design den Entwurf unter `_requirements/mockups/<kurzer-name>/`; vorhandenen Code nach Bedarf.
-   **Nichts ändern** — keine Dateien, keine Befehle mit Wirkung. Ausnahme: Der Klicktester startet die App und legt Screenshots unter `.qa/` ab (wird nicht committet).
-   **Nur im eigenen Blick prüfen;** was zu einer anderen Rolle gehört, höchstens kurz erwähnen.
-   **Keine Entscheidungen der Anforderung neu verhandeln** (Stack, Verhalten, Umfang). Hält eine Entscheidung nicht: als Befund mit Begründung melden — sie geht dann zurück ins Refinement (beim Entwurf: in die Klärung).
-   **Vertraulichkeit:** keine Namen, Links, Zugangsdaten in Befunden.

## Ergebnis

Eine Liste von Befunden, **ohne Schweregrad** — die Einstufung macht der Agent (unten). Je Befund: **was** (ein Satz), **warum** (Folge, wenn es so bleibt — und ob sie durch diese Änderung entsteht oder schon vorher bestand), **Vorschlag** (konkrete Änderung am Entwurf, am Plan bzw. an der Umsetzung). Was sich nicht prüfen ließ, als **offene Frage** dazu. Ohne Befund: ausdrücklich „keine Befunde" — nicht künstlich etwas finden.

## Einstufung durch den Agenten

Der Agent, der die Prüfer startet, ordnet jeden Befund ein — Befunde mehrerer Rollen zur selben Sache als einen, mit Nennung aller Rollen.

**Schwere** aus der Folge:

-   **hoch** — ein Akzeptanzkriterium oder eine Entscheidung wird verfehlt, Daten gehen verloren, die App lässt sich nicht starten oder bedienen, oder eine Lücke ist tatsächlich ausnutzbar — unabhängig vom Anspruch;
-   **mittel** oder **niedrig** — gemessen am Anspruch (Zeile `Anspruch` der Anforderung, sonst `_context/projekt.md`, fehlt beides: `normal`): mittel ist ein spürbarer Fehler oder Mehraufwand im Betrieb, niedrig eine Kleinigkeit oder ein Fall, der bei diesem Anspruch kaum eintritt.

**Durch die Änderung verursacht** ist, was sie neu einführt — auch ein bestehender Fehler, den sie neu erreichbar oder schlimmer macht.

**Gruppe** — die erste passende:

1.  **verwerfen** — der Befund hält am Entwurf, am Plan bzw. am Code nicht. Unbelegtes und offene Fragen der Rollen prüft der Agent selbst nach; bleibt es offen, geht es weiter mit Punkt 2, mit der Schwere, die es hätte, wenn es zutrifft, und als „keine klare Lösung".
2.  **Prüfung auf blockierend** (Liste unten): hält eine Entscheidung der Anforderung nicht → **entscheiden**, mit nur zwei Wegen (den Vorschlag der Rolle innerhalb der Entscheidung umsetzen oder die Entscheidung im Refinement ändern, beim Entwurf: in der Klärung); ohne klaren Weg → **entscheiden**; sonst → **umsetzen**.
3.  **zurückstellen** — nicht durch die Änderung verursacht: Eintrag in `_requirements/deferred/` (Regeln in der `README.md` dort) oder, wenn jemand es angehen will, Issue (Stufe 1). Bei Schwere hoch fragt der Agent den Nutzer (siehe unten).
4.  **vermerken** — Schwere niedrig: nicht umsetzen, nur festhalten.
5.  **entscheiden** — mehrere sinnvolle Wege, keine klare Lösung, die Lösung würde Anliegen, Abgrenzung oder eine Entscheidung ausweiten, oder Rollen widersprechen sich. Der Nutzer entscheidet, mit Empfehlung des Agenten.
6.  **umsetzen** — alles Übrige: durch die Änderung verursacht, Schwere mittel oder hoch, eine klare Lösung.

**Blockierend** heißt: so darf der Schritt nicht abgeschlossen werden (Entwurf bzw. Plan nicht freigeben, nicht zur Abnahme, kein Release-Pull-Request) — auch wenn es schon vorher so war. Immer blockierend:

-   abgeschwächte Tests;
-   ein neuer oder geänderter Test, der nie scheitern kann (z. B. eine Prüfung auf Abwesenheit ohne Gegenprobe); bei alten Tests: zurückstellen als Bug-Issue (Stufe 1);
-   Tests, die der Plan erst nach ihrem Code vorsieht;
-   eine Entscheidung der Anforderung, die nicht hält;
-   eine App, die sich nicht starten oder bedienen lässt;
-   Schwere hoch und durch die Änderung verursacht (z. B. Datenverlust, ausnutzbare Lücke);
-   ein wiederkehrender Handgriff von Hand, wenn jeder Stand automatisch live geht (sonst nach Schwere).

**Behelf:** Ist eine Änderung nur vorübergehend nötig (z. B. bis ein anderes Issue erledigt ist), steht an der Stelle selbst „bleibt bis #<Nummer>", und der Agent kommentiert im Issue #<Nummer>, welcher Behelf danach wegfällt.

**Dem Nutzer** legt der Agent einzeln vor: „entscheiden" (je Befund ein Satz, die Wege, seine Empfehlung) und Zurückgestelltes mit Schwere hoch (Frage: Issue oder Eintrag in `_requirements/deferred/`; in dieser Anforderung nur als Ausweitung nach `_agent-process/AGENTS.md`, Abschnitt „Halten"). Die übrigen nennt er in einem Satz mit ihrer Zahl je Gruppe. Wo alle stehen, sagt die jeweilige Stufe.
