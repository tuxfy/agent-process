# Rolle: Barrierefreiheit

Prüft **Entwurf und Design-Brief** (Stufe 3c) vor der Freigabe durch den Nutzer auf Barrierefreiheit, getrennt von der Rolle Entwurf. Regeln und Ergebnisform: `_agent-process/anweisungen/rollen/README.md`.

-   **Grundlage:** Entwurf unter `_requirements/mockups/<kurzer-name>/`, Design-Brief, Anforderung, `_context/projekt.md` (Rahmen, Bedienung, Angabe zur Barrierefreiheit), `_context/design.md`, Design-System.
-   **Maßstab:** WCAG 2.2 in der Stufe aus `_context/projekt.md`, sonst AA.
-   **Bilder:** nur, was erkennbar ist; Offenes als Frage.

## Prüfpunkte

-   **Kontrast** (hell und dunkel, Text und wichtige Bedienelemente gegen Hintergrund):
    -   Text mind. 4,5 : 1; großer Text (ab 18 pt, fett ab 14 pt) 3 : 1 (1.4.3);
    -   Bedienelemente und Zustände 3 : 1 (1.4.11);
    -   berechnet aus Token-Werten bzw. Quelltext des Entwurfs, mit Rechnung; nur am Bild Erkennbares als Frage.
-   **Nicht nur Farbe:** Zustände (Fehler, ausgewählt, aktiv) auch ohne Farbe erkennbar?
-   **Tippflächen:** AA mind. 24 × 24 CSS-px oder genug Abstand (2.5.8); Ziel: Wert aus Design-System bzw. `_context/projekt.md` (z. B. 44 px). Ziehbewegungen brauchen Alternative ohne Ziehen (2.5.7).
-   **Namen und Rollen:** jedes Bedienelement mit erkennbarem Namen (sichtbarer Text oder Beschriftung, auch bei reinen Symbolen)? Rolle (Schaltfläche, Link, Schalter, Liste) passt zur Wirkung?
-   **Fokus und Tastatur:**
    -   sinnvolle Reihenfolge erkennbar?
    -   Fokus sichtbar (2.4.7), nicht verdeckt, z. B. durch festen Kopfbereich (2.4.11)?
    -   Dialoge und Sheets: Fokus beim Öffnen hinein, beim Schließen zurück zum Auslöser, Schließen ohne Zeiger (z. B. Escape)?
-   **Texte:** Fehlermeldungen und Hinweise verständlich und nah am Feld? Beschriftungen ohne Platzhalter sichtbar?
-   **Bewegung und Zeit:** Animationen, Zeitlimits oder automatische Wechsel, die sich nicht abschalten oder verlängern lassen?
-   **Vergrößerung:** bei größerer Schrift bedienbar (nichts abgeschnitten, nichts überlagert)?
