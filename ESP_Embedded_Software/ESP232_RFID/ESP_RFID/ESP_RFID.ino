#include <SPI.h>      // SPI-Bibiothek hinzufügen
#include <MFRC522.h>  // RFID-Bibiothek hinzufügen

#define SS_PIN 21   // SDA an Pin 10 (bei MEGA anders)
#define RST_PIN 22  // RST an Pin 9 (bei MEGA anders)


MFRC522 mfrc522(SS_PIN, RST_PIN);  // RFID-Empfänger benennen

void setup()  // Beginn des Setups:

{
  Serial.begin(115200);  // Serielle Verbindung starten (Monitor)
  SPI.begin();           // SPI-Verbindung aufbauen
  mfrc522.PCD_Init();  // Initialisierung des RFID-Empfängers
}

void loop()  // Hier beginnt der Loop-Teil
{
  if (mfrc522.PICC_IsNewCardPresent()) {
    if (mfrc522.PICC_ReadCardSerial()) {
        for (byte i = 0; i < mfrc522.uid.size; i++) {
          Serial.print(mfrc522.uid.uidByte[i], HEX);
          Serial.print(" ");
        }
      }else{
        Serial.print("NCF-Tag ohne ID gelesen ");
      } 
    Serial.println();
  }
}