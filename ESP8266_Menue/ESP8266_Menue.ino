// eingehende befehlswörter in einer schleife werden under der Variable *Schleifenname*_c gespeichert
// bools um in einer Schleife zu bleiben werden unter *Schleifenname*_l gespeichert


#include <sstream>
#include <string>

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
MFRC522 mfrc522(SS_PIN, RST_PIN); //NFC Reader
time_t now;  // this are the seconds since Epoch (1970) - UTC
tm tm;       // the structure tm holds time information in a more convenient way
unsigned long last_reset;
unsigned long time_by_user;

void setup() {
  Serial.begin(115200);
  SPI.begin();
  mfrc522.PCD_Init();
  InitalizeFileSystem();
}

void loop() {
  while (Serial.available()) {
    String menue_c = Serial.readStringUntil('\n');
    if (menue_c == "set_time"){
      set_time();
    }
    if (menue_c == "set_ID"){
      set_ID();
    }
    if (menue_c == "race"){
      race();
    }
    if (menue_c == "file"){
      file();
    }
  }
}

void set_time(){
  bool set_time_l=true;
  while (set_time_l){
    //Serial.println("test set_time");
    print_time(get_time());
    while (Serial.available()) {
      String set_time_c = Serial.readStringUntil('\n');
      if (set_time_c=="sync"){
        sync_time(25*60*1000);
      }
      if (set_time_c=="q"){
        set_time_l=false;
      }
    }
  }
}

void set_ID(){
  bool set_ID_l=true;
  while (set_ID_l){
    Serial.println("test set_ID");
  set_ID_l=false;
  }
}

void race(){
  bool race_l=true;
  while (race_l){
    Serial.println("test race");
  race_l=false;
  }
}

void file(){
  bool file_l=true;
  while (file_l){
    Serial.println("test file");
  file_l=false;
  }
}

unsigned long get_time() {
  return time(&now)*1000 + (millis()%1000) - last_reset + time_by_user;
}

void sync_time(unsigned long current_time_by_user){
   last_reset = time(&now)*1000 + (millis()%1000);
   time_by_user = current_time_by_user;
}

void print_time(unsigned long ms) { //Ausgabe format hh:mm:ss:msmsms
  // Berechne die Stunden, Minuten, Sekunden und Millisekunden
  unsigned long hours = ms / 3600000;
  ms = ms % 3600000;
  unsigned long minutes = ms / 60000;
  ms = ms % 60000;
  unsigned long seconds = ms / 1000;
  unsigned long milliseconds = ms % 1000;

  // Gib das formatierte Ergebnis aus
  Serial.print(hours);
  Serial.print(":");
  if (minutes < 10) Serial.print("0");
  Serial.print(minutes);
  Serial.print(":");
  if (seconds < 10) Serial.print("0");
  Serial.print(seconds);
  Serial.print(":");
  if (milliseconds < 10) Serial.print("00");
  else if (milliseconds < 100) Serial.print("0");
  Serial.println(milliseconds);
}

boolean InitalizeFileSystem() {  //vom SPIFFS Demoprogramm kopiert, Wird in der setup benötigt für File-Managmante
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