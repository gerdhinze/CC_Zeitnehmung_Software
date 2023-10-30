#include <SPI.h>
#include <MFRC522.h>

#define SS_PIN 4
#define RST_PIN 0
#define LS1 5
#define LS2 16

MFRC522 mfrc522(SS_PIN, RST_PIN);

unsigned long lastResetTime = 0; // Variable zum Speichern der letzten Reset-Zeit

void setup() {
  Serial.begin(115200);
  SPI.begin();
  mfrc522.PCD_Init();
  pinMode(LS1, INPUT);
  pinMode(LS2, INPUT);
  lastResetTime = millis(); // Initialisiere die letzte Reset-Zeit auf die aktuelle Zeit
}

void loop() {
  reset_time();
  nfc();
  schranke(LS1);

}

void nfc() {
  if (mfrc522.PICC_IsNewCardPresent()) {
    if (mfrc522.PICC_ReadCardSerial()) {
        Serial.print("Event 1: NCF-Tag gelesen mit ID ");
        for (byte i = 0; i < mfrc522.uid.size; i++) {
          Serial.print(mfrc522.uid.uidByte[i], HEX);
          Serial.print(" ");
        }
      }else{
        Serial.print("Event 1: NCF-Tag ohne ID gelesen ");
    
      } 
    timer();
    Serial.println();
  }
}

void schranke(int input){
  bool LS = digitalRead(input);
  if (LS) {
    Serial.print("Event 2: Lichtschranke ");
    Serial.print(input);
    Serial.print(" ");
    timer();
    Serial.println();
  }
}

void reset_time(){// Setze den Timer auf die aktuelle Zeit zurück
  while (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    if (command == "reset") {
      lastResetTime = millis();
      Serial.println("Timer zurückgesetzt");
    }
  }
}

void timer(){
  unsigned long milliseconds = millis()-lastResetTime;
  unsigned long seconds = milliseconds / 1000;
  unsigned long minutes = seconds / 60;
  unsigned long hours = minutes / 60;
  unsigned long remainingMilliseconds = milliseconds % 1000;
  seconds %= 60;
  minutes %= 60;
  Serial.print(hours);
  Serial.print(":");
  Serial.print(minutes);
  Serial.print(":");
  Serial.print(seconds);
  Serial.print(":");
  Serial.print(remainingMilliseconds);
}