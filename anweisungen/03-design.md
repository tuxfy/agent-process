# Stufe 3: Design

Nur bei Bedarf — für neue oder deutlich veränderte Screens (z. B. ein neues Menü), wenn in der Klärung **„Design nötig: ja"** festgelegt wurde. Kleine Änderungen folgen direkt der UI-Richtlinie in `_agent-process/AGENTS.md`. Ablauf in Teilschritten:

| Teilschritt | Wer | Ergebnis |
|---|---|---|
| 3a Ausgangslage | Agent | kurzer Text zum Kopieren: nur Fakten aus der Klärung, **keine Gestaltung** |
| 3b Entwurf | **Nutzer, extern** | Entwurf **und Design-Brief** entstehen außerhalb des Projekts, in einem Werkzeug seiner Wahl (z. B. Chat mit Ansicht, Design-Werkzeug) — **der Agent im Projekt wartet** |
| 3c Übergabe und Freigabe | Nutzer stellt bereit, Agent prüft | Entwurf unter `_requirements/mockups/<kurzer-name>/`, Brief im Anforderungsdokument, vom Nutzer freigegeben, Lücken eingetragen |

**Der Entwurf entsteht extern, nicht in der Arbeitsumgebung des Projekts** (CLI, Container) — z. B. in einem Chat mit Ansicht oder einem Design-Werkzeug. Der Agent im Projekt baut dafür kein Mockup und keinen Prototyp: Dort läuft ein Entwurf in Details und nimmt die Umsetzung vorweg. Auch den Design-Brief schreibt er nicht vorab — ein Brief aus dem Projekt legt Gestaltung fest, bevor jemand entworfen hat. Er liefert die Ausgangslage, wartet auf Entwurf und Brief und prüft beides gegen die Anforderung.

## Grundsätze

-   **Faustregel — was gehört wohin:** Würde ein zweites Projekt es auch brauchen? Ja → Design-System (Tokens, Komponenten, allgemeine Muster, Vorlagen-Seiten). Nein → Projekt (konkrete Screens, Texte, Zuordnungen).
-   **In sich geschlossene Module** (z. B. ein Intervall-Timer) kommen **als Ganzes** ins Design-System — als Vorlage mit allen Zuständen, nicht nur in Einzelteilen; die Bausteine bleiben darunter erhalten.
-   **Aussehen ja, Logik nein:** Das Design-System zeigt, wie etwas aussieht, welche Zustände es gibt und wie sie wechseln (als Beschreibung). Logik (Berechnung, Abläufe, Speichern, Geräte-Funktionen) gehört in die App — oder, wenn mehrere Apps sie teilen, in ein eigenes Modul-Repo.
-   **Das Design-System wird benutzt, nie bearbeitet.** Es ist zentral und liegt außerhalb des Projekts.
-   **App-Spezifisches bleibt im Projekt:** Entwürfe, Texte und Zuordnungen (z. B. welcher Ton was bedeutet) stehen in `_context/design.md`, nicht im Design-System.
-   **Fehlt etwas im Design-System** (Komponente, Wert, Muster):
    1.  in `_context/design.md` unter „Lokal umgesetzt — gehört ins Design-System" benennen,
    2.  im Projekt vorerst lokal umsetzen — mit den Tokens des Design-Systems, so nah wie möglich an dessen Regeln,
    3.  als Idee für das Design-System vermerken, damit es später von dort verwendet und die lokale Lösung ersetzt wird.

## 3a: Ausgangslage

Der Agent gibt dem Nutzer einen **kurzen Text zum Kopieren** — nur Fakten aus Idee und Klärung, so, dass er ohne Wissen über das Projekt verständlich ist:

1.  **Ziel** — was der Nutzer danach tun kann (aus der Idee).
2.  **Ist-Stand** — was es heute gibt (ein, zwei Sätze).
3.  **Spielraum** — was sich ändern darf, was unverändert bleibt (aus der Klärung).
4.  **Feste Grenzen** — Daten bzw. Felder, Wertebereiche, Zustände, vorgegebene Texte.
5.  **Rahmen** — Gerät, Bildschirmgröße, hell/dunkel, Bedienung (aus `_context/projekt.md`).
6.  **Design-System** — welches; nur dessen Tokens und Komponenten nutzen, Fehlendes als Lücke benennen.

**Nicht hinein:** Aufbau von Screens, Anordnung, Wahl von Komponenten, Abläufe der Bedienung, Gestaltungsideen — das entsteht im Entwurf. Fehlt eine Angabe, fragt der Agent den Nutzer, statt sie zu erfinden.

## 3b: Entwurf (extern)

-   Nach der Ausgangslage **wartet** der Agent, bis der Nutzer Entwurf und Brief bereitstellt. Er fragt nicht nach und beginnt nichts anderes an dieser Anforderung.
-   Der Nutzer entwirft extern mit der Ausgangslage und überarbeitet dort, bis er zufrieden ist. **Am Ende entsteht dort auch der Design-Brief:** was der Entwurf festlegt (Aufbau, Zustände, Abläufe, Texte, genutzte Komponenten, Lücken) — gegliedert wie der Abschnitt `# Design-Brief` der Vorlage.

## 3c: Übergabe und Freigabe

-   **Der Nutzer stellt Entwurf und Brief bereit** — den Brief als Text, den Entwurf als Datei bzw. Ordner (z. B. HTML mit Laufzeit, Bilder, Screenshots) unter `_requirements/mockups/<kurzer-name>/` — oder er gibt sie dem Agenten, der sie unverändert dort ablegt. Den Brief übernimmt der Agent unverändert in `# Design-Brief`.
-   **Der Agent prüft Entwurf und Brief gegen die Anforderung** (Ausgangslage, Klärung) und meldet dem Nutzer — ohne beides zu ändern:
    -   Abweichungen von den festen Grenzen (Felder, Wertebereiche, Zustände, Texte) und vom Rahmen (Gerät, hell/dunkel);
    -   **Lücken:** was der Entwurf nutzt, das das Design-System nicht hat (siehe Grundsätze);
    -   offene Fragen, die sich aus dem Entwurf ergeben.
    -   Ändern muss der Nutzer extern; danach stellt er den neuen Stand bereit.
-   **Die Ablage muss für sich allein laufen:** jede lokal verwiesene Datei (`src`, `href`, Skripte, Bilder) liegt mit im Ordner oder verweist relativ auf die Kopie des Design-Systems im Projekt. Fehlt etwas, meldet der Agent es dem Nutzer.
-   **Vertraulichkeit:** keine Links zu Projekt, System oder Dritten; eingebettete Metadaten in Bildern entfernen. Technische Adressen von Bibliotheken in der Laufzeit des Entwurfs (z. B. aus einem CDN mit fester Version) sind in Ordnung.
-   Der **Nutzer gibt den Entwurf frei.** Offene Lücken stehen dann in `_context/design.md` unter „Lokal umgesetzt — gehört ins Design-System" und sind als Idee für das Design-System vermerkt.
-   Im Anforderungsdokument unter dem Brief: `Entwurf: _requirements/mockups/<kurzer-name>/`.
-   Widersprechen sich Entwurf und Brief: der Nutzer entscheidet, was gilt, und korrigiert extern.

## Hinweis für die Umsetzung

-   Der freigegebene Entwurf ist maßgeblich. **Ausführbare Entwürfe** (z. B. HTML): Werte, Texte und Formeln werden aus der Quelle **übernommen, nicht nachempfunden**. **Bilder:** sie zeigen Aufbau und Zustände; Werte kommen aus den Tokens des Design-Systems.
-   Umgesetzt wird immer mit den Tokens und Komponenten des Design-Systems.
