## Danach: ein größeres Projekt Richtung AI Engineering

Das Autostart-Projekt ist eher ein Wochenend-Ding. Für dein eigentliches Ziel wäre diese Reihenfolge sinnvoll:

1. **Image-Classifier als C++-CLI mit ONNX Runtime:** Bild laden, auf 224×224×3 skalieren, Tensor bauen (deine `Tensor`-Klasse), Inferenz laufen lassen, Top-5-Klassen ausgeben. Das nutzt fast alles aus Woche 1, und du kannst ein ResNet/MobileNet-Modell aus dem ONNX Model Zoo nehmen.
2. **Benchmarking:** Miss die Inferenzzeit (`std::chrono`), vergleiche FP32 mit einem INT8-quantisierten Modell und baue das Ganze mit CMake.
3. **Ausbau:** Kamera-Livebild oder Object Detection mit deiner Detection-Sortierung aus Übung 6 plus Non-Max-Suppression.

Du kannst beides kombinieren: Das Autostart-Programm startet später deinen Classifier als Hintergrunddienst.

Soll ich dir als Nächstes ein CMake-Projektgerüst für das ONNX-Projekt aufsetzen, oder erst die RAII-Klasse für den Registry-Key ausarbeiten?
