# Rollen für Prüfungen

Unabhängige Prüfer mit frischem Blick. Sie ändern nichts am Projekt. Wann welche Rolle prüft, steht in der jeweiligen Stufe (3c, 5a, 6, 8b) bzw. im Skill. In Claude Code laufen sie als Unteragenten (`.claude/agents/`), sonst als eigene Sitzung je Rolle. Mehrere laufen parallel; der Agent führt die Ergebnisse zusammen. Reviewer, Security und Testwirkung (6b) bekommen den Diff als Datei: Der Agent schreibt ihn vor jedem Lauf neu nach `.qa/diff.txt`, wenn alles committet ist: `git fetch`, dann `git diff origin/<Ziel>...HEAD` — Ziel ist das Ziel des Pull Requests (`release-candidate`; bei der Abkürzung oder solange es `release-candidate` noch nicht gibt: `main`).

**Blick je Rolle:**

-   **Design (3c):** Entwurf (Abläufe, Zustände, Design-System, Brief, Umsetzbarkeit) · Barrierefreiheit (Kontrast, Namen, Fokus, Tippflächen)
-   **Plan:** Architekt (Aufbau, Schnitt, Abhängigkeiten, Größe) · Senior Dev (Code, Tests, Reihenfolge, Fehlerfälle, Umgebung und Container) · DevOps (alles ab dem Commit: CI, Hosting, Release, Betrieb)
-   **Umsetzung:** Reviewer (Code gegen Anforderung, Plan und Entscheidungen) · Security (Sicherheit nach Checkliste) · Testwirkung (würden die Tests Fehler finden?) · Klicktester (die laufende App wie ein Mensch)
-   **Vorlage an den Nutzer:** Challenger (Behauptungen am Code, frühere Entscheidungen, einfachere Wege)
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

Der Agent, der die Prüfer startet, ordnet jeden Befund ein; Befunde mehrerer Rollen zur selben Sache als einen. Maßstab: Ein Schritt ist fertig, wenn er das Ziel erreicht und den Stand eindeutig verbessert, nicht wenn er perfekt ist. Deshalb wird nur Blockierendes umgesetzt.

**Gruppe** — die erste passende:

1.  **verwerfen** — hält am Entwurf, Plan bzw. Code nicht. Unbelegtes prüft der Agent selbst nach; bleibt es offen, weiter mit Punkt 2, als träfe es zu und ohne klare Lösung.
2.  **blockierend** (Liste unten): **entscheiden** (der Nutzer, mit Empfehlung des Agenten), wenn eine Entscheidung der Anforderung nicht hält — dann nur zwei Wege: innerhalb der Entscheidung beheben oder sie im Refinement (beim Entwurf: in der Klärung) ändern —, bei mehreren sinnvollen Wegen, ohne klare Lösung, wenn Rollen sich widersprechen oder die Lösung Anliegen, Abgrenzung oder eine Entscheidung ausweiten würde; sonst **umsetzen**.
3.  **zurückstellen** — nicht durch die Änderung verursacht: Eintrag in `_requirements/deferred/` (Regeln in der `README.md` dort) oder Issue (Stufe 1), wenn jemand es angehen will.
4.  **vermerken** — alles Übrige: nicht umsetzen, nur festhalten (wo, sagt die jeweilige Stufe).

**Durch die Änderung verursacht** ist, was sie neu einführt — auch ein bestehender Fehler, den sie neu erreichbar oder schlimmer macht.

**Blockierend** heißt: So darf der Schritt nicht abgeschlossen werden (Entwurf bzw. Plan nicht freigeben, nicht zur Abnahme, kein Release-Pull-Request), auch wenn es schon vorher so war:

-   abgeschwächte Tests oder ein neuer bzw. geänderter Test, der nie scheitern kann (z. B. Prüfung auf Abwesenheit ohne Gegenprobe); alte Tests dieser Art: zurückstellen als Bug-Issue;
-   Tests, die der Plan erst nach ihrem Code vorsieht;
-   eine Entscheidung der Anforderung, die nicht hält;
-   eine App, die sich nicht starten oder bedienen lässt;
-   Datenverlust oder eine ausnutzbare Lücke, durch die Änderung verursacht — unabhängig vom Anspruch;
-   ein anderer Fehler, den die Änderung verursacht, in einem Fall, der beim Anspruch eintreten kann: Absturz, falsches Ergebnis, verschluckter Fehler, Abweichung von der Anforderung;
-   Overengineering: ein Teil über die gewählte Lösung hinaus, für den die Anforderung keinen Grund nennt und ohne den kein anderer Punkt dieser Liste einträte (Tests eigener Logik ausgenommen) — Lösung: weglassen;
-   ein wiederkehrender Handgriff von Hand, wenn jeder Stand automatisch live geht.

**Schwere** (für Zurückgestelltes und für Bugs, `_agent-process/anweisungen/vorlagen/bug.md`): **hoch**, wenn ein Akzeptanzkriterium oder eine Entscheidung verfehlt wird, Daten verloren gehen, die App nicht startet oder nicht bedienbar ist oder eine Lücke ausnutzbar ist; sonst gemessen am Anspruch (Zeile `Anspruch` der Anforderung, sonst `_context/projekt.md`, fehlt beides: `normal`) **mittel** (spürbarer Fehler oder Mehraufwand im Betrieb) oder **niedrig**.

**Behelf:** Ist eine Änderung nur vorübergehend nötig (z. B. bis ein anderes Issue erledigt ist), steht an der Stelle selbst „bleibt bis #<Nummer>", und der Agent kommentiert im Issue #<Nummer>, welcher Behelf danach wegfällt.

**Dem Nutzer** legt der Agent einzeln vor: „entscheiden" (je Befund ein Satz, die Wege, seine Empfehlung) und Zurückgestelltes mit Schwere hoch (Frage: Issue oder Eintrag in `_requirements/deferred/`; in dieser Anforderung nur als Ausweitung nach `_agent-process/AGENTS.md`, Abschnitt „Halten"). Die übrigen nennt er in einem Satz mit ihrer Zahl je Gruppe. Wo alle stehen, sagt die jeweilige Stufe.
