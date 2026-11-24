# Stufe 3: Design

Nur bei Bedarf: neue oder deutlich veränderte Screens (z. B. neues Menü), wenn in der Klärung **„Design nötig? ja"** festgelegt. Kleine Änderungen folgen direkt der UI-Richtlinie (`_agent-process/skills/ap-guideline-ui/SKILL.md`).

| Teilschritt | Wer | Ergebnis |
|---|---|---|
| 3a Ausgangslage | Agent | kurzer Text zum Kopieren: nur Fakten aus der Klärung, **keine Gestaltung** |
| 3b Entwurf | **Nutzer, extern** | Entwurf **und Design-Brief** entstehen außerhalb des Projekts, in einem Werkzeug seiner Wahl (z. B. Chat mit Ansicht, Design-Werkzeug) — **der Agent im Projekt wartet** |
| 3c Übergabe und Freigabe | Nutzer stellt bereit, Agent und Rollen prüfen | Entwurf unter `_requirements/mockups/<kurzer-name>/`, Brief im Anforderungsdokument, vom Nutzer freigegeben, Lücken eingetragen |

**Entwurf entsteht extern,** nicht in der Arbeitsumgebung des Projekts (CLI, Container); z. B. in einem Chat mit Ansicht oder Design-Werkzeug.

-   Der Agent im Projekt baut kein Mockup und keinen Prototyp: dort läuft ein Entwurf in Details und nimmt die Umsetzung vorweg.
-   Er schreibt auch den Design-Brief nicht vorab: ein Brief aus dem Projekt legt Gestaltung fest, bevor jemand entworfen hat.
-   Er liefert die Ausgangslage, wartet auf Entwurf und Brief, prüft beides gegen die Anforderung.

## Grundsätze

Design-System, Tokens, Komponenten, Lücken: Skill `ap-guideline-ui` (`_agent-process/skills/ap-guideline-ui/SKILL.md`).

## 3a: Ausgangslage

**Kurzer Text zum Kopieren** für den Nutzer; nur Fakten aus Anliegen und Klärung, ohne Projektwissen verständlich:

1.  **Ziel:** Zeile „Ziel" unter „Einordnung".
2.  **Ist-Stand:** was es heute gibt (ein, zwei Sätze).
3.  **Spielraum:** was sich ändern darf, was bleibt (aus der Klärung).
4.  **Feste Grenzen:** Daten bzw. Felder, Wertebereiche, Zustände, vorgegebene Texte.
5.  **Rahmen:** Gerät, Bildschirmgröße, hell/dunkel, Bedienung (aus `_context/projekt.md`).
6.  **Design-System:** welches; nur dessen Tokens und Komponenten nutzen, Fehlendes als Lücke benennen.
7.  **Gliederung des Design-Briefs:** Überschriften aus `# Design-Brief` der Vorlage, leer, ohne Zeile „Entwurf", damit der Brief extern passend entsteht.

-   **Nicht hinein:** Aufbau von Screens, Anordnung, Wahl von Komponenten, Abläufe der Bedienung, Gestaltungsideen; das entsteht im Entwurf.
-   Fehlt eine Angabe: Nutzer fragen, nicht erfinden.

## 3b: Entwurf (extern)

-   Nach der Ausgangslage **warten,** bis der Nutzer Entwurf und Brief bereitstellt. Nicht nachfragen, nichts anderes an dieser Anforderung beginnen.
-   **Extern wird nicht committet,** auch wenn das externe Werkzeug Zugriff auf den Projektordner hat. Es legt Entwurf und Brief höchstens als Dateien unter `_requirements/mockups/<kurzer-name>/` ab; kein git, keine Zwischenstände im Verlauf.
-   Nutzer entwirft extern mit der Ausgangslage, überarbeitet dort bis er zufrieden ist. **Am Ende entsteht dort auch der Design-Brief:** was der Entwurf festlegt, gegliedert wie am Ende der Ausgangslage angegeben.

## 3c: Übergabe und Freigabe

-   **Nutzer stellt bereit:** Brief als Text, Entwurf als Datei bzw. Ordner (z. B. HTML mit Laufzeit, Bilder, Screenshots) unter `_requirements/mockups/<kurzer-name>/`; oder er gibt sie dem Agenten, der sie unverändert dort ablegt.
-   Brief unverändert in `# Design-Brief` übernehmen; Zeile `Entwurf: _requirements/mockups/<kurzer-name>/` setzt der Agent.
-   **Prüfung durch Rollen, immer:** **Entwurf** (Abgleich mit der Anforderung: feste Grenzen, Rahmen, Abläufe, Zustände, Design-System, Entwurf gegen Brief) und **Barrierefreiheit** (`_agent-process/anweisungen/rollen/README.md`); ohne Entwurf und Brief zu ändern.
-   **Agent prüft selbst** nur, was er für die Ablage braucht: läuft für sich, vertraulich (unten), welche **Lücken** er nach der UI-Richtlinie einträgt (`_agent-process/skills/ap-guideline-ui/SKILL.md`).
-   **Prüfbericht:**
    -   alle Befunde und offenen Fragen zusammenführen, einordnen (`_agent-process/anweisungen/einstufung.md`), dem Nutzer vorlegen; alle Befunde mit ihrer Gruppe;
    -   „umsetzen" heißt hier: Empfehlung an den Nutzer, der extern ändert;
    -   was der Nutzer bewusst nicht ändert → Eintrag in `_requirements/deferred/` (Regeln in der `README.md` dort), committet mit dem Entwurf; unter Zeile `Entwurf:` in `# Design-Brief` dann `Zurückgestellt:` mit den Dateinamen.
-   Ändern muss der Nutzer extern; danach stellt er den neuen Stand bereit; eigene Prüfung und Rollen laufen erneut.
-   **Ablage läuft für sich:** jede lokal verwiesene Datei (`src`, `href`, Skripte, Bilder) liegt im Ordner oder verweist relativ auf die Kopie des Design-Systems im Projekt. Fehlt etwas: dem Nutzer melden.
-   **Vertraulichkeit:** keine Links zu Projekt, System oder Dritten; eingebettete Metadaten in Bildern entfernen. Technische Adressen von Bibliotheken in der Laufzeit des Entwurfs (z. B. CDN mit fester Version) sind in Ordnung.
-   **Nutzer gibt den Entwurf frei;** offene Lücken sind dann nach der UI-Richtlinie eingetragen.
-   **Erst nach der Freigabe committen,** einmal: Entwurf, Brief, eingetragene Lücken, ggf. Einträge in `_requirements/deferred/` (Format: `_agent-process/AGENTS.md`, „Git").
-   Entwurf und Brief widersprechen sich: Nutzer entscheidet, was gilt, korrigiert extern.

## Hinweis für die Umsetzung

-   Freigegebener Entwurf ist maßgeblich.
-   **Ausführbare Entwürfe** (z. B. HTML): Werte, Texte, Formeln aus der Quelle **übernehmen, nicht nachempfinden**.
-   **Bilder:** zeigen Aufbau und Zustände; Werte aus den Tokens des Design-Systems.
