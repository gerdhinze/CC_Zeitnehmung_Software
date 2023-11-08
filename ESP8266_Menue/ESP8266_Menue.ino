#include <sstream>
#include <string>

#include <ESP8266WiFi.h>  // we need wifi to get internet access
#include <time.h>         // for time() ctime()
#include <SPI.h>
#include <MFRC522.h>    //NFC Reader
#include <FS.h>  // Nutze die SPIFFS library


#define SS_PIN 4
#define RST_PIN 0
#define LS1 5
#define LS2 16

//Globals
File myfile;                   // erstelle ein SPIFFS Handling Variable
MFRC522 mfrc522(SS_PIN, RST_PIN);


void setup() {
  Serial.begin(115200);
  SPI.begin();
  mfrc522.PCD_Init();
  InitalizeFileSystem();
}

void loop() {
  while (Serial.available()) {
    String command = Serial.readStringUntil('\n');
  if (command == "test"){
    Serial.println("1");
    Serial.println("2");
    Serial.println("3");
  }
  }


}


boolean InitalizeFileSystem() 
{
  bool initok = false;
  initok = SPIFFS.begin();
  if (!(initok)) // Format SPIFS, of not formatted. - Try 1
  {
    Serial.println("Format SPIFFS");
    SPIFFS.format();
    initok = SPIFFS.begin();
  }
  if (!(initok)) // Format SPIFS, of not formatted. - Try 2
  {
    SPIFFS.format();
    initok = SPIFFS.begin();
  }
  if (initok) { Serial.println("SPIFFS ist OK"); } else { Serial.println("SPIFFS ist nicht OK"); }
  return initok;
}