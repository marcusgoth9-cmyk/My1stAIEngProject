## Danach: ein größeres Projekt Richtung AI Engineering

Das Autostart-Projekt ist eher ein Wochenend-Ding. Für dein eigentliches Ziel wäre diese Reihenfolge sinnvoll:

1. **Image-Classifier als C++-CLI mit ONNX Runtime:** Bild laden, auf 224×224×3 skalieren, Tensor bauen (deine `Tensor`-Klasse), Inferenz laufen lassen, Top-5-Klassen ausgeben. Das nutzt fast alles aus Woche 1, und du kannst ein ResNet/MobileNet-Modell aus dem ONNX Model Zoo nehmen.
2. **Benchmarking:** Miss die Inferenzzeit (`std::chrono`), vergleiche FP32 mit einem INT8-quantisierten Modell und baue das Ganze mit CMake.
3. **Ausbau:** Kamera-Livebild oder Object Detection mit deiner Detection-Sortierung aus Übung 6 plus Non-Max-Suppression.

Du kannst beides kombinieren: Das Autostart-Programm startet später deinen Classifier als Hintergrunddienst.

Soll ich dir als Nächstes ein CMake-Projektgerüst für das ONNX-Projekt aufsetzen, oder erst die RAII-Klasse für den Registry-Key ausarbeiten?
## Nächste Schritte

Wichtig: Das ist ein Zielbild, keine Liste von Dateien, die du sofort alle befüllen musst. Für den ersten Schritt reichen CMakeLists.txt, README.md und src/main.cpp. Die übrigen Dateien kommen dazu, sobald du sie brauchst.

Aufgaben der wichtigsten Dateien
main.cpp: Argumente entgegennehmen, z. B. Bild- und Modellpfad; Classifier aufrufen und Ergebnisse ausgeben.
image_preprocessing.*: Bild laden, passend zum Modell skalieren, normalisieren und in das erwartete Tensorformat umwandeln.
classifier.*: ONNX-Modell laden, Inferenz ausführen und Ergebnisse für die Ausgabe bereitstellen.
labels.txt: Ordnet die Ausgabewerte den passenden Klassennamen zu.
models/README.md: Dokumentiert Modellquelle, Version, Lizenz und benötigte Vorverarbeitung.
Deine vorhandene Tensor-Klasse kannst du später einbinden, wenn ihr Speicherlayout und Datentyp zum ONNX-Modell passen. Sie muss nicht zwingend das gesamte ONNX-Tensorhandling ersetzen.

## 2. Ordner anlegen
In PowerShell, ausgehend vom Repository-Hauptordner:


Den Ordner build legt CMake beim Konfigurieren selbst an.

## 3. .gitignore einrichten
Eine sinnvolle erste Version im Projektordner:


Große Modelldateien bleiben damit lokal. Die Datei models/README.md und die Labels können weiterhin versioniert werden. Prüfe vor dem Hochladen von Testbildern und Labels deren Lizenz.

## 4. In dieser Reihenfolge entwickeln
Schritt 1: CMake und ein minimales Programm
Starte mit einem Programm, das nur eine Meldung ausgibt. So überprüfst du zuerst, ob C++-Compiler und CMake auf deinem Windows-System funktionieren.

Danach konfigurierst und baust du das Projekt beispielsweise so:


Schritt 2: Ein konkretes Modell auswählen
Wähle ein Modell und dokumentiere:

Downloadquelle, Version und Lizenz
erwartete Eingabeform und Datentyp, z. B. [1, 3, 224, 224] und float
Farbkanalreihenfolge und Normalisierung
Zuordnung der Ausgaben zu Klassen
Nicht jedes Modell erwartet dieselbe Vorverarbeitung. 224 × 224 ist häufig, aber du musst dich nach dem tatsächlich gewählten Modell richten.

Schritt 3: Abhängigkeiten integrieren
Für die erste Version brauchst du:

ONNX Runtime für die Inferenz
eine Bildbibliothek, z. B. OpenCV, zum Laden und Skalieren
CMake für den Build
Unter Windows ist vcpkg eine mögliche Paketverwaltung. Halte die konkreten Abhängigkeiten und Build-Schritte anschließend in der README.md fest, damit das Projekt reproduzierbar bleibt.

Schritt 4: Ein Bild klassifizieren
Ziel für die erste funktionierende Version:


Das Programm soll das Bild verarbeiten, die Inferenz ausführen und die Top 5 mit Klassennamen und Werten ausgeben. Ob die Modellwerte bereits Wahrscheinlichkeiten sind oder erst per Softmax umgewandelt werden müssen, hängt vom Modell ab.

Schritt 5: Tests und Benchmarking
Teste zuerst die Vorverarbeitung und die Sortierung der Top-Ergebnisse. Für den Benchmark trennst du Modellladezeit, Vorverarbeitung und Inferenzzeit. Nach einigen Aufwärmläufen misst du mehrere Durchläufe und vergleichst FP32 und INT8 unter denselben Bedingungen – einschließlich eines Blicks auf die Ergebnisqualität.

## 5. Was in die README gehört
Schon zu Beginn genügen:

## Ziel: Was macht der Classifier?
Voraussetzungen: Compiler, CMake und benötigte Bibliotheken.
Build: Befehle zum Konfigurieren und Kompilieren.
Ausführung: Beispiel mit Modell und Bild.
Modell: Quelle, Lizenz und erwartete Vorverarbeitung.
Status: Was funktioniert bereits, was ist geplant?
Mein Rat: Baue zuerst den Weg „ein Bild rein → fünf Klassen raus“ vollständig durch. Das ist ein überschaubarer Meilenstein und eine saubere Grundlage für Benchmarking und spätere Erweiterungen.