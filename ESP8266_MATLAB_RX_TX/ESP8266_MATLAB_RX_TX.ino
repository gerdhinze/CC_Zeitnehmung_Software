
int number =0;
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
      Serial.println("Zahl: " + String(number)); // Sende die Zahl zurück zum Serial Monitor
    } 
    else if (input.startsWith("set ")) {
      // Extrahiere den Wert aus dem Eingabestring und setze die Variable
      number = input.substring(4).toInt(); // Beginne ab dem 5. Zeichen (Index 4)
      Serial.println("Wert_wurde_auf_" + String(number) + "_gesetzt");
    }
  }
}
