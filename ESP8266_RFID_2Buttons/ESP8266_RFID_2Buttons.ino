#include <SPI.h>
#include <MFRC522.h>

#define SS_PIN 4
#define RST_PIN 9
#define LS1 5
#define LS2 16

MFRC522 mfrc522(SS_PIN, RST_PIN);

void setup() {
  Serial.begin(9600);
  SPI.begin();
  mfrc522.PCD_Init();
  pinMode(LS1, INPUT);
  pinMode(LS2, INPUT);
}

void loop() {
  if (mfrc522.PICC_IsNewCardPresent()) {
    if (mfrc522.PICC_ReadCardSerial()) {
      Serial.print("Event 3: NCF-Tag gelesen mit ID: ");
      for (byte i = 0; i < mfrc522.uid.size; i++) {
        Serial.print(mfrc522.uid.uidByte[i], HEX);
        Serial.print(" ");
      }
      Serial.println();
    }
  }

  bool value_LS1 = digitalRead(LS1);
  bool value_LS2 = digitalRead(LS2);

  if (value_LS1) {
    Serial.println("Event 1: Lichtschranke 1 ausgelöst");
  }

  if (value_LS2) {
    Serial.println("Event 2: Lichtschranke 2 ausgelöst");
  }
}
