int variableWert = 0; 

void setup() 
{
  Serial.begin(115200); // Starten Sie die serielle Kommunikation mit 115200 Baud
}

void loop() 
{
  if (Serial.available() > 0) 
  {
    String input = Serial.readStringUntil('\n'); // Liest die Eingabezeile bis zum Zeilenumbruch (\n)
    input.trim(); // Entfernt führende und abschließende Leerzeichen
    
    // Wenn der Befehl "set" eingegeben wurde
    if (input == "set") 
    {
      Serial.println("Bitte geben Sie einen Wert ein:");
      while (Serial.available() <= 0) 
      {
        // Warten Sie, bis etwas im Serial Monitor eingegeben wird
      }
      variableWert = Serial.parseInt(); // Liest den eingegebenen Wert und speichert ihn in variableWert
      Serial.println("Wert wurde gesetzt.");
    }
    
    // Wenn der Befehl "get" eingegeben wurde
    else if (input == "get") 
    {
      Serial.print("Aktueller Wert der Variable: ");
      Serial.println(variableWert);
    }
  }
}
