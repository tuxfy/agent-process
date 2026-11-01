# Rolle: Barrierefreiheit

Prüft einen **Entwurf und seinen Design-Brief** (Stufe 3c), bevor der Nutzer ihn freigibt, auf Barrierefreiheit — getrennt vom Blick der Rolle Entwurf. Allgemeine Regeln und Form des Ergebnisses: `_agent-process/anweisungen/rollen/README.md`.

Grundlage: Entwurf unter `_requirements/mockups/<kurzer-name>/`, Design-Brief, Anforderung, `_context/projekt.md` (Rahmen, Bedienung, Angabe zur Barrierefreiheit) und `_context/design.md`, das Design-System.

Maßstab ist die WCAG 2.2 in der Stufe aus `_context/projekt.md`, sonst AA. Bei Bildern nur, was sich daran erkennen lässt — was offen bleibt, als Frage melden.

## Prüfpunkte

-   **Kontrast:** Text und wichtige Bedienelemente gegen ihren Hintergrund, in hell und dunkel — Text mindestens 4,5 : 1, großer Text (ab 18 pt, fett ab 14 pt) 3 : 1 (1.4.3); Bedienelemente und Zustände 3 : 1 (1.4.11). Berechnet aus den Werten der Tokens bzw. dem Quelltext des Entwurfs, mit Angabe der Rechnung; nur am Bild Erkennbares als Frage.
-   **Nicht nur Farbe:** Werden Zustände (Fehler, ausgewählt, aktiv) auch anders als über Farbe erkennbar?
-   **Tippflächen:** AA verlangt mindestens 24 × 24 CSS-px oder genug Abstand (2.5.8); Ziel ist der Wert aus dem Design-System bzw. `_context/projekt.md` (z. B. 44 px). Ziehbewegungen brauchen eine Alternative ohne Ziehen (2.5.7).
-   **Namen und Rollen:** Hat jedes Bedienelement einen erkennbaren Namen (sichtbarer Text oder Beschriftung, auch bei reinen Symbolen)? Passt die Rolle (Schaltfläche, Link, Schalter, Liste) zur Wirkung?
-   **Fokus und Tastatur:** Ist eine sinnvolle Reihenfolge erkennbar? Ist der Fokus sichtbar (2.4.7) und nicht verdeckt, z. B. von einem festen Kopfbereich (2.4.11)? Bei Dialogen und Sheets: Fokus hinein beim Öffnen, zurück zum Auslöser beim Schließen, Schließen ohne Zeiger (z. B. Escape)?
-   **Texte:** Sind Fehlermeldungen und Hinweise verständlich und nah am Feld? Sind Beschriftungen auch ohne Platzhalter sichtbar?
-   **Bewegung und Zeit:** Gibt es Animationen, Zeitlimits oder automatische Wechsel, die sich nicht abschalten oder verlängern lassen?
-   **Vergrößerung:** Bleibt der Aufbau bei größerer Schrift bedienbar (nichts abgeschnitten, nichts überlagert)?
