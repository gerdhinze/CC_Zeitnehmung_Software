#include <SPI.h>
#include <MFRC522.h>

#define SS_PIN 4
#define RST_PIN 0
#define LS1 5
#define LS2 16

MFRC522 mfrc522(SS_PIN, RST_PIN);

unsigned long lastResetTime = 0; // Variable zum Speichern der letzten Reset-Zeit
bool resetRequested = false; // Flag, um einen Reset anzufordern

void setup() {
  Serial.begin(9600);
  SPI.begin();
  mfrc522.PCD_Init();
  pinMode(LS1, INPUT);
  pinMode(LS2, INPUT);
  lastResetTime = millis(); // Initialisiere die letzte Reset-Zeit auf die aktuelle Zeit
}

void loop() {
  unsigned long currentTime = millis(); // Aktuelle Zeit abrufen

  if (resetRequested) {
    resetTimer();
    resetRequested = false; // Setze die Flag zurück
  }

  if (mfrc522.PICC_IsNewCardPresent()) {
    if (mfrc522.PICC_ReadCardSerial()) {
      Serial.print("Event 1: NCF-Tag gelesen mit ID ");
      for (byte i = 0; i < mfrc522.uid.size; i++) {
        Serial.print(mfrc522.uid.uidByte[i], HEX);
        Serial.print(" ");
      }
      Serial.print("Zeit seit dem letzten Reset: ");
      printTimeDifference(currentTime - lastResetTime);
      Serial.println();
    }
    else{
      Serial.print("Event 1: NCF-Tag ohne ID gelesen ");
      Serial.print("Zeit seit dem letzten Reset: ");
      printTimeDifference(currentTime - lastResetTime);
      Serial.println();
    }
  }


  bool value_LS1 = digitalRead(LS1);
  bool value_LS2 = digitalRead(LS2);

  if (value_LS1) {
    Serial.print("Event 2: Lichtschranke 1 ausgelöst - Zeit seit dem letzten Reset: ");
    printTimeDifference(currentTime - lastResetTime);
    Serial.println();
  }

  if (value_LS2) {
    Serial.print("Event 3: Lichtschranke 2 ausgelöst - Zeit seit dem letzten Reset: ");
    printTimeDifference(currentTime - lastResetTime);
    Serial.println();
  }

  // Überprüfen, ob serielle Daten verfügbar sind, um den Timer zurückzusetzen
  while (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    if (command == "reset") {
      resetRequested = true; // Setze die Flag, um einen Reset anzufordern
    }
  }
}


void resetTimer() {
  lastResetTime = millis(); // Setze den Timer auf die aktuelle Zeit zurück
  Serial.println("Timer zurückgesetzt");
}

void printTimeDifference(unsigned long milliseconds) {
  unsigned long seconds = milliseconds / 1000;
  unsigned long minutes = seconds / 60;
  unsigned long hours = minutes / 60;
  
  // Berechne die Millisekunden, die nach Stunden, Minuten und Sekunden übrig bleiben
  unsigned long remainingMilliseconds = milliseconds % 1000;
  seconds %= 60;
  minutes %= 60;

  Serial.print(hours);
  Serial.print("h ");
  Serial.print(minutes);
  Serial.print("min ");
  Serial.print(seconds);
  Serial.print("sek ");
  Serial.print(remainingMilliseconds);
  Serial.print("ms");
}

