# Stufe 3: Design

Nur bei Bedarf — für neue oder deutlich veränderte Screens (z. B. ein neues Menü), wenn in der Klärung **„Design nötig? ja"** festgelegt wurde. Kleine Änderungen folgen direkt der UI-Richtlinie (`_agent-process/skills/ap-guideline-ui/SKILL.md`). Ablauf in Teilschritten:

| Teilschritt | Wer | Ergebnis |
|---|---|---|
| 3a Ausgangslage | Agent | kurzer Text zum Kopieren: nur Fakten aus der Klärung, **keine Gestaltung** |
| 3b Entwurf | **Nutzer, extern** | Entwurf **und Design-Brief** entstehen außerhalb des Projekts, in einem Werkzeug seiner Wahl (z. B. Chat mit Ansicht, Design-Werkzeug) — **der Agent im Projekt wartet** |
| 3c Übergabe und Freigabe | Nutzer stellt bereit, Agent und Rollen prüfen | Entwurf unter `_requirements/mockups/<kurzer-name>/`, Brief im Anforderungsdokument, vom Nutzer freigegeben, Lücken eingetragen |

**Der Entwurf entsteht extern, nicht in der Arbeitsumgebung des Projekts** (CLI, Container) — z. B. in einem Chat mit Ansicht oder einem Design-Werkzeug. Der Agent im Projekt baut dafür kein Mockup und keinen Prototyp: Dort läuft ein Entwurf in Details und nimmt die Umsetzung vorweg. Auch den Design-Brief schreibt er nicht vorab — ein Brief aus dem Projekt legt Gestaltung fest, bevor jemand entworfen hat. Er liefert die Ausgangslage, wartet auf Entwurf und Brief und prüft beides gegen die Anforderung.

## Grundsätze

Was ins Design-System gehört und wie mit Tokens, Komponenten und Lücken umzugehen ist: Skill `ap-guideline-ui` (`_agent-process/skills/ap-guideline-ui/SKILL.md`).

## 3a: Ausgangslage

Der Agent gibt dem Nutzer einen **kurzen Text zum Kopieren** — nur Fakten aus Anliegen und Klärung, so, dass er ohne Wissen über das Projekt verständlich ist:

1.  **Ziel** — was der Nutzer danach tun kann (aus dem Anliegen).
2.  **Ist-Stand** — was es heute gibt (ein, zwei Sätze).
3.  **Spielraum** — was sich ändern darf, was unverändert bleibt (aus der Klärung).
4.  **Feste Grenzen** — Daten bzw. Felder, Wertebereiche, Zustände, vorgegebene Texte.
5.  **Rahmen** — Gerät, Bildschirmgröße, hell/dunkel, Bedienung (aus `_context/projekt.md`).
6.  **Design-System** — welches; nur dessen Tokens und Komponenten nutzen, Fehlendes als Lücke benennen.
7.  **Gliederung des Design-Briefs** — die Überschriften aus `# Design-Brief` der Vorlage, leer und ohne die Zeile „Entwurf", damit der Brief extern passend entsteht.

**Nicht hinein:** Aufbau von Screens, Anordnung, Wahl von Komponenten, Abläufe der Bedienung, Gestaltungsideen — das entsteht im Entwurf. Fehlt eine Angabe, fragt der Agent den Nutzer, statt sie zu erfinden.

## 3b: Entwurf (extern)

-   Nach der Ausgangslage **wartet** der Agent, bis der Nutzer Entwurf und Brief bereitstellt. Er fragt nicht nach und beginnt nichts anderes an dieser Anforderung.
-   **Extern wird nicht committet** — auch nicht, wenn das externe Werkzeug Zugriff auf den Projektordner hat. Es legt Entwurf und Brief höchstens als Dateien unter `_requirements/mockups/<kurzer-name>/` ab; kein git, keine Zwischenstände im Verlauf.
-   Der Nutzer entwirft extern mit der Ausgangslage und überarbeitet dort, bis er zufrieden ist. **Am Ende entsteht dort auch der Design-Brief** — was der Entwurf festlegt, gegliedert wie am Ende der Ausgangslage angegeben.

## 3c: Übergabe und Freigabe

-   **Der Nutzer stellt Entwurf und Brief bereit** — den Brief als Text, den Entwurf als Datei bzw. Ordner (z. B. HTML mit Laufzeit, Bilder, Screenshots) unter `_requirements/mockups/<kurzer-name>/` — oder er gibt sie dem Agenten, der sie unverändert dort ablegt. Den Brief übernimmt der Agent unverändert in `# Design-Brief`; die Zeile `Entwurf: _requirements/mockups/<kurzer-name>/` setzt er selbst.
-   **Prüfung durch Rollen — immer:** die Rollen **Entwurf** (Abgleich mit der Anforderung: feste Grenzen, Rahmen, Abläufe, Zustände, Design-System, Entwurf gegen Brief) und **Barrierefreiheit** (Prüfer-Rollen, siehe `_agent-process/anweisungen/rollen/README.md`) — ohne Entwurf und Brief zu ändern.
-   **Der Agent prüft selbst** nur, was er für die Ablage braucht: ob sie für sich läuft und vertraulich ist (unten) und welche **Lücken** er nach der UI-Richtlinie einträgt (`_agent-process/skills/ap-guideline-ui/SKILL.md`).
-   Er führt alle Befunde und offenen Fragen zusammen, stuft sie ein und legt sie dem Nutzer in einem Prüfbericht vor. Was der Nutzer bewusst nicht ändert, kommt als Eintrag nach `_requirements/deferred/` (Regeln in der `README.md` dort) und wird mit dem Entwurf committet; unter der Zeile `Entwurf:` in `# Design-Brief` setzt der Agent dann `Zurückgestellt:` mit den Dateinamen.
-   Ändern muss der Nutzer extern; danach stellt er den neuen Stand bereit, und eigene Prüfung und Rollen laufen erneut.
-   **Die Ablage muss für sich allein laufen:** jede lokal verwiesene Datei (`src`, `href`, Skripte, Bilder) liegt mit im Ordner oder verweist relativ auf die Kopie des Design-Systems im Projekt. Fehlt etwas, meldet der Agent es dem Nutzer.
-   **Vertraulichkeit:** keine Links zu Projekt, System oder Dritten; eingebettete Metadaten in Bildern entfernen. Technische Adressen von Bibliotheken in der Laufzeit des Entwurfs (z. B. aus einem CDN mit fester Version) sind in Ordnung.
-   Der **Nutzer gibt den Entwurf frei.** Offene Lücken sind dann nach der UI-Richtlinie eingetragen.
-   **Erst nach der Freigabe committet der Agent im Projekt** — einmal: Entwurf, Brief, eingetragene Lücken und ggf. Einträge in `_requirements/deferred/` (Format: `_agent-process/AGENTS.md`, Abschnitt „Git").
-   Widersprechen sich Entwurf und Brief: der Nutzer entscheidet, was gilt, und korrigiert extern.

## Hinweis für die Umsetzung

-   Der freigegebene Entwurf ist maßgeblich. **Ausführbare Entwürfe** (z. B. HTML): Werte, Texte und Formeln werden aus der Quelle **übernommen, nicht nachempfunden**. **Bilder:** sie zeigen Aufbau und Zustände; Werte kommen aus den Tokens des Design-Systems.
