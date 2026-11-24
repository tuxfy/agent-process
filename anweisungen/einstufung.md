# Einstufung durch den Agenten

-   Der Agent, der die Prüfer startet, ordnet jeden Befund ein; Befunde mehrerer Rollen zur selben Sache als einen.
-   Maßstab: Schritt fertig, wenn das Ziel erreicht und der Stand eindeutig besser ist, nicht perfekt. Umgesetzt wird nur Blockierendes.

## Gruppe (die erste passende)

1.  **verwerfen:** hält am Entwurf, Plan bzw. Code nicht. Unbelegtes selbst nachprüfen; bleibt es offen: weiter mit 2, als träfe es zu und ohne klare Lösung.
2.  **blockierend** (Liste unten):
    -   **entscheiden** (Nutzer, mit Empfehlung des Agenten), wenn
        -   eine Entscheidung der Anforderung nicht hält — nur zwei Wege: innerhalb der Entscheidung beheben oder sie im Refinement ändern (beim Entwurf: in der Klärung);
        -   mehrere sinnvolle Wege oder keine klare Lösung;
        -   Rollen sich widersprechen;
        -   die Lösung Anliegen, Abgrenzung oder eine Entscheidung ausweiten würde.
    -   sonst **umsetzen**.
3.  **zurückstellen:** nicht durch die Änderung verursacht → Eintrag in `_requirements/deferred/` (Regeln in der `README.md` dort) oder Issue (Stufe 1), wenn es jemand angehen will.
4.  **vermerken:** alles Übrige; nicht umsetzen, nur festhalten (wo: jeweilige Stufe).

**Durch die Änderung verursacht:** was sie neu einführt, auch ein bestehender Fehler, den sie neu erreichbar oder schlimmer macht.

## Blockierend

Schritt nicht abschließen (Entwurf bzw. Plan nicht freigeben, nicht zur Abnahme, kein Release-Pull-Request), auch wenn es schon vorher so war:

-   abgeschwächter Test; neuer oder geänderter Test, der nie scheitern kann (z. B. Prüfung auf Abwesenheit ohne Gegenprobe) — alte Tests dieser Art: als Bug-Issue zurückstellen;
-   Tests, die der Plan erst nach ihrem Code vorsieht;
-   Entscheidung der Anforderung hält nicht;
-   App startet nicht oder ist nicht bedienbar;
-   Datenverlust oder ausnutzbare Lücke, durch die Änderung verursacht — unabhängig vom Anspruch;
-   anderer Fehler durch die Änderung, in einem Fall, der beim Anspruch eintreten kann: Absturz, falsches Ergebnis, verschluckter Fehler, Abweichung von der Anforderung;
-   Overengineering: Teil über die gewählte Lösung hinaus, ohne Grund in der Anforderung und ohne den kein anderer Punkt dieser Liste einträte (Tests eigener Logik ausgenommen) → weglassen;
-   Doku oder `_context/`, die durch die Änderung falsch wird;
-   wiederkehrender Handgriff von Hand, wenn jeder Stand automatisch live geht.

„Blockierend" nur mit Nennung des Listenpunkts; passt keiner, nicht blockierend.

## Schwere

Für Zurückgestelltes und Bugs (`_agent-process/anweisungen/vorlagen/bug.md`):

-   **hoch:** Akzeptanzkriterium oder Entscheidung verfehlt, Datenverlust, App startet nicht oder ist nicht bedienbar, ausnutzbare Lücke;
-   sonst gemessen am Anspruch (Zeile `Anspruch` der Anforderung, sonst `_context/projekt.md`, fehlt beides: `normal`): **mittel** (spürbarer Fehler oder Mehraufwand im Betrieb) oder **niedrig**.

## Behelf

Änderung nur vorübergehend nötig (z. B. bis ein anderes Issue erledigt ist) → an der Stelle „bleibt bis #<Nummer>"; im Issue #<Nummer> kommentieren, welcher Behelf danach wegfällt.

## Dem Nutzer

-   Einzeln: „entscheiden" (je Befund ein Satz, die Wege, Empfehlung) und Zurückgestelltes mit Schwere hoch (Frage: Issue oder Eintrag in `_requirements/deferred/`; in dieser Anforderung nur als Ausweitung nach `_agent-process/AGENTS.md`, „Halten").
-   Die übrigen: ein Satz mit Zahl je Gruppe. Wo alle stehen, sagt die jeweilige Stufe.
