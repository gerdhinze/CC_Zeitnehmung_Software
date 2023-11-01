void setup() {
  Serial.begin(115200); // Starte die serielle Kommunikation mit einer Baudrate von 115200
}

void loop() {
  // Warte darauf, bis Daten im Serial Monitor verfügbar sind
  if (Serial.available() > 0) {
    String input = Serial.readStringUntil('\n'); // Lies die Eingabe bis zum Zeilenumbruch
    input.trim(); // Entferne Leerzeichen am Anfang und Ende
    
    // Wenn der Eingabebefehl "get" ist, gib eine zufällige Zahl aus
    if (input.equals("get")) {
      int randomNumber = random(100); // Erzeuge eine zufällige Zahl zwischen 0 und 99
      Serial.println("Zufällige Zahl: " + String(randomNumber)); // Sende die Zahl zurück zum Serial Monitor
    } else {
      Serial.println("Ungültiger Befehl. Bitte 'get' eingeben."); // Falls der Befehl nicht "get" ist, gib eine Fehlermeldung aus
    }
  }
  
  delay(100); // Kurze Verzögerung, um die CPU zu entlasten
}
