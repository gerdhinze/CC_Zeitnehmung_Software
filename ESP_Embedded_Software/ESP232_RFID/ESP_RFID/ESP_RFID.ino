#include <SPI.h> // SPI-Bibiothek hinzufügen
#include <MFRC522.h> // RFID-Bibiothek hinzufügen

#define SS_PIN 21 // SDA an Pin 10 (bei MEGA anders)
#define RST_PIN 22 // RST an Pin 9 (bei MEGA anders)
#define LS1 11     //Lichtschranke 1
#define LS2 10     //Lichtschranke 2

MFRC522 mfrc522(SS_PIN, RST_PIN); // RFID-Empfänger benennen

void setup() // Beginn des Setups:

{

Serial.begin(115200); // Serielle Verbindung starten (Monitor)
SPI.begin(); // SPI-Verbindung aufbauen

mfrc522.PCD_Init(); // Initialisierung des RFID-Empfängers
pinMode(LS1, INPUT);
pinMode(LS2, INPUT);
}

void loop() // Hier beginnt der Loop-Teil
{

bool value_LS1 = digitalRead(LS1);
bool value_LS2 = digitalRead(LS2);

if ( ! mfrc522.PICC_IsNewCardPresent()) // Wenn keine Karte in Reichweite ist...
{

return; // ...springt das Programm zurück vor die if-Schleife, womit sich die Abfrage wiederholt.

}

if ( ! mfrc522.PICC_ReadCardSerial()) // Wenn kein RFID-Sender ausgewählt wurde
{

return; // ...springt das Programm zurück vor die if-Schleife, womit sich die Abfrage wiederholt.
}


Serial.print("Die ID des RFID-TAGS lautet: "); // "Die ID des RFID-TAGS lautet:" wird auf den Serial Monitor geschrieben.

for (byte i = 0; i < mfrc522.uid.size; i++)
{
Serial.print(mfrc522.uid.uidByte[i], HEX); // Dann wird die UID ausgelesen, die aus vier einzelnen Blöcken besteht und der Reihe nach an den Serial Monitor gesendet. Die Endung Hex bedeutet, dass die vier Blöcke der UID als HEX-Zahl (also auch mit Buchstaben) ausgegeben wird
Serial.print(" "); // Der Befehl „Serial.print(" ");“ sorgt dafür, dass zwischen den einzelnen ausgelesenen Blöcken ein Leerzeichen steht.
}

if(value_LS1 == 1)
{
  Serial.print("Lichtschranke 1 ausgelöst");
}
else if(value_LS2 == 1)
{
  Serial.print("Lichtschranke 2 ausgelöst");
}
Serial.println(); // Mit dieser Zeile wird auf dem Serial Monitor nur ein Zeilenumbruch gemacht.
}
