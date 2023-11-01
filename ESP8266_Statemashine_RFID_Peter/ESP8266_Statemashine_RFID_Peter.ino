#ifndef STASSID
#define WLAN_SSID "x3"                            // set your SSID
#define PW  "12345678"                        // set your wifi password
#endif


#include <sstream>
#include <string>

#include <ESP8266WiFi.h>            // we need wifi to get internet access
#include <time.h>                   // for time() ctime()
#include <SPI.h>
#include <MFRC522.h>
#include <FS.h>           // Nutze die SPIFFS library

#define SS_PIN 4
#define RST_PIN 0
#define LS1 5
#define LS2 16

MFRC522 mfrc522(SS_PIN, RST_PIN);

/* Configuration of NTP */
#define MY_NTP_SERVER "at.pool.ntp.org"           
#define MY_TZ "CET-1CEST,M3.5.0/02,M10.5.0/03"  

/* Globals */
time_t now;                         // this are the seconds since Epoch (1970) - UTC
tm tm;                              // the structure tm holds time information in a more convenient way
int ms;
unsigned long lastResetTime = 0;  // Variable zum Speichern der letzten Reset-Zeit
unsigned long realtime_set = 0;
uint64_t IDs[10];                 //Array in dem die IDs gespeichert werden
int IDs_init_position = 2;
int maxarraysize = 40;
bool scanning = false;  // Variable, um den Scan-Status zu verfolgen um IDs ein
unsigned long race_start_time = 0;
File myfile;                   // erstelle ein SPIFFS Handling Variable

void setup() {
  Serial.begin(115200);
  SPI.begin();
  mfrc522.PCD_Init();
  pinMode(LS1, INPUT);
  pinMode(LS2, INPUT);
  InitalizeFileSystem();    
  lastResetTime = millis();  // Initialisiere die letzte Reset-Zeit auf die aktuelle Zeit
  IDs[0] = 0;
  IDs[1] = 1;

  //Network und RtC setup
  configTime(MY_TZ, MY_NTP_SERVER); // --> Here is the IMPORTANT ONE LINER needed in your sketch!

  // start network
  WiFi.persistent(false);
  WiFi.mode(WIFI_STA);
  WiFi.begin(WLAN_SSID, PW);
  while (WiFi.status() != WL_CONNECTED) {
    delay(200);
    Serial.print ( "." );
  }
}

void loop() {  //TODO Menue hizufügen
  while (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    if (command == "set") {
      set_ID();
    }
    if (command == "set all") {
      Serial.println("set all");
      scanning = true;  // Starte den Scann-Status
      while (scanning) {
        set_ID();
        delay(1000);
      }
    }
    if (command == "show") {
      show_IDs();
    }
    if (command == "clear") {
      clearAll();
      delete_all();
    }
    if (command == "race") {
      race(); 
    }
    if (command == "read") {
      read_times(2); 
    }
    if (command == "init") { //nur zum debugen
      InitalizeFileSystem();
    }
  }
}

void set_ID() {  //zeigt an wo im Array die ID ist und fügt diese hinzu fall noch nicht vorhanden mit get_ID und addToUniqueArray
  int position = addToUniqueArray(get_ID(), IDs, IDs_init_position, maxarraysize);
  Serial.print(position);
  Serial.print(" = ");
  Serial.print(IDs[position], HEX);
  Serial.println();
}

uint64_t get_ID() { //gibt ID als uint64_t zurück. "q" um abzubrachen. bei abruch wird 0 zurück gegeben 
  uint64_t rfidID = 0;
  bool scan = true;  // Variable, um den Scan-Status zu verfolgen

  Serial.println("Ready to scan");
  while (scan) {
    if (mfrc522.PICC_IsNewCardPresent()) {
      if (mfrc522.PICC_ReadCardSerial()) {
        for (byte i = 0; i < mfrc522.uid.size; i++) {
          rfidID = (rfidID << 8) | mfrc522.uid.uidByte[i];
        }
        scan = false;  // Beende den Scan, da eine gültige ID gefunden wurde
      }
    }

    while (Serial.available()) {
      String command = Serial.readStringUntil('\n');
      if (command == "q") {
        Serial.println("quit");
        scan = false;  // Beende den Scan, wenn "q" eingegeben wird
        scanning = false;  // Variable, um den Scan-Status zu verfolgen
      }
    }
  }
  return rfidID;
}

int addToUniqueArray(uint64_t value, uint64_t arr[], int &arrSize, int maxSize) {  //Gibt die Position der ID zurück und fügt neue hinzu
    // Überprüfen, ob der Wert bereits im Array vorhanden ist
    for (int i = 0; i < arrSize; i++) {
      if (arr[i] == value) {
        return i;  // Wert bereits vorhanden, gib die Position zurück
      }
    }

    // Wenn der Wert einzigartig ist und Platz im Array vorhanden ist, hinzufügen
    if (arrSize < maxSize) {
      arr[arrSize] = value;
      arrSize++;
      return arrSize - 1;  // Gib die Position zurück, an der der Wert hinzugefügt wurde
    } else {
      // Array ist voll, erhöhe die Größe des Arrays (optional)
        if (arrSize < maxSize * 2) {
          arrSize = maxSize * 2;
          arr[arrSize - 1] = value;
          return arrSize - 1;  // Gib die Position zurück, an der der Wert hinzugefügt wurde
        } else {
            return -1;  // Array ist voll und kann nicht erweitert werden, gib -1 zurück
          }
    }
}

void scanLoop() {
  while (scanning) {
    set_ID();
  }
}

void show_IDs() {  //zeigt alle gespeicherten ID und die Position im array
  for (int i = 0; i < IDs_init_position; i++) {
    Serial.print(i);
    Serial.print(" = ");
    Serial.println(IDs[i], HEX);
  }
}

void clearAll() {
  int defaultIDs[] = {0, 1};  // Die Standard-IDs, die nicht gelöscht werden sollen

  for (int i = IDs_init_position - 1; i >= 0; i--) {
    bool keepID = false;

    for (int j = 0; j < sizeof(defaultIDs) / sizeof(defaultIDs[0]); j++) {
      if (IDs[i] == defaultIDs[j]) {
        keepID = true;
        break;
      }
    }

    if (!keepID) {
      // ID löschen, indem es mit der letzten ID im Array überschrieben wird
      IDs[i] = IDs[IDs_init_position - 1];
      IDs_init_position--;
      Serial.print(i);
      Serial.println(" cleared");
    }
  }
}

void race(){
  bool racemode = true;
  Serial.println("Racemode");
  timer_reset();
  creat_file_for_IDs();
  while (racemode){
    while (Serial.available()) {
      String command = Serial.readStringUntil('\n');
      if (command == "q") {
        Serial.println("Race end");
        racemode = false;
      }
      if (command == "start") {
        bool racestart = true;
        race_start_time = get_time();
        print_time(realtime_set);
        print_time(race_start_time);
        while (racestart){
          while (Serial.available()) {
            String command = Serial.readStringUntil('\n');
            if (command == "q") {
              Serial.println("stop");
              racestart = false;
            }
            
          }
          uint64_t rfidID = 0;
          std::string path;
          if (mfrc522.PICC_IsNewCardPresent()) {
            if (mfrc522.PICC_ReadCardSerial()) {
              for (byte i = 0; i < mfrc522.uid.size; i++) {
                rfidID = (rfidID << 8) | mfrc522.uid.uidByte[i];
              }
              int position = position_im_array(IDs,rfidID);
              path = "/"+std::to_string(position)+".csv";
              myfile = SPIFFS.open(path.c_str(), "a");
              myfile.println(get_time());
              myfile.close();
              Serial.print(position);
              Serial.print(" ");
              Serial.println(get_time());

            }else{
            int position = position_im_array(IDs,rfidID);
            path = "/"+std::to_string(position)+".csv";
            myfile = SPIFFS.open(path.c_str(), "a");
            myfile.println(get_time());
            myfile.close();
            Serial.print(position);
            Serial.print(" ");
            Serial.println(get_time());
            }
          }
        }
      }
    } 
  }
}


void timer_reset(){
  lastResetTime = millis();
  delay(2000);
  time(&now);
  localtime_r(&now, &tm);
  realtime_set = tm.tm_sec*1000 + tm.tm_min*60*1000 +tm.tm_hour *60 *60 *1000;
}

unsigned long get_time(){
  return realtime_set+millis()-lastResetTime;
}

void print_time(unsigned long ms) {
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

void InitalizeFileSystem() {
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
}

int position_im_array(uint64_t arr[],uint64_t value){
  for (int i = 0; i < IDs_init_position; i++) {
      if (arr[i] == value) {
        return i;  // Wert bereits vorhanden, gib die Position zurück
      }
    }
    return 0;
}

void creat_file_for_IDs(){
  std::string path;
  for (int i = 0; i < IDs_init_position; i++){
    path = "/"+std::to_string(i)+".csv";
    myfile = SPIFFS.open(path.c_str(), "a");
    myfile.print("Race init ");
    myfile.println(get_time());
    myfile.println(IDs[i],HEX);
    myfile.close();
    Serial.println(path.c_str());
    }

}

void read_times(int ID_position){
  std::string path;
  path = "/"+std::to_string(ID_position)+".csv";
  myfile = SPIFFS.open(path.c_str(), "r");
  while (myfile.position()<myfile.size()){            // lese Dateiinhbalt Zeile für Zeile bis um Ende der Datei
    Serial.println(myfile.readStringUntil('\n'));
  } 
  myfile.close();
}

bool delete_file(int ID_position){
  std::string path;
  path = "/"+std::to_string(ID_position)+".csv";
  // check if file exists 
  if (SPIFFS.exists (path.c_str())){  //Prüfe ob Datei usage_log.csv schon exisiert.
    SPIFFS.remove(path.c_str());  //Lösche Datei  
    Serial.print(path.c_str());
    Serial.println(" wurde gelöscht.");
    return true;
  }
  else{return false;}

}

void delete_all(){
  for (int i = 0; i<maxarraysize; i++){
    delete_file(i);
  }
}
