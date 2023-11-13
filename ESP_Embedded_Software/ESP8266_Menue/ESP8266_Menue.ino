// eingehende befehlswörter in einer schleife werden under der Variable *Schleifenname*_c gespeichert
// bools um in einer Schleife zu bleiben werden unter *Schleifenname*_l gespeichert


#include <sstream>
#include <string>
#include <map>


#include <time.h>  // for time() ctime()
#include <SPI.h>
#include <MFRC522.h>  //NFC Reader
#include <FS.h>       // Nutze die SPIFFS library

class NFCEventTracker{
public:
    bool is_duplicate_event(unsigned long nfc_id, unsigned long timestamp,unsigned long delaytime)
    {
        std::map<unsigned long/*nfc id*/, unsigned long/*timestamp*/>::const_iterator last = _last_events.find(nfc_id);
        if (last != _last_events.end()) {
            unsigned long last_timestamp = last->second;
            if (timestamp - last_timestamp < delaytime)
                return true;
        }
        _last_events[nfc_id] = timestamp;
        return false;
    }

    void clear() { _last_events.clear(); }

private:
    std::map<unsigned long/*nfc id*/, unsigned long/*timestamp*/> _last_events;
};



#define SS_PIN 4
#define RST_PIN 0
#define LS1 5
#define LS2 16

//Globals
File myfile;                       // erstelle ein SPIFFS Handling Variable
MFRC522 mfrc522(SS_PIN, RST_PIN);  //NFC Reader
time_t now;                        // this are the seconds since Epoch (1970) - UTC
tm tm;                             // the structure tm holds time information in a more convenient way
unsigned long last_reset = 0;
unsigned long time_by_user = 0;
int station = 3;
String logpath = "log.csv";

void setup() {
  Serial.begin(115200);
  SPI.begin();
  mfrc522.PCD_Init();
  InitalizeFileSystem();
}

void loop() {
  while (Serial.available()) {
    String menue_c = Serial.readStringUntil('\n');
    if (menue_c == "sync_time") { //fertig
      sync_time();
    }
    if (menue_c == "get_time") { //fertig
      get_time();
    }
    if (menue_c == "set_ID") { //fertig
      set_ID(); //gibt nur die ID zurück
    }
    if (menue_c == "read_log") {
      read_log(); 
    }
    if (menue_c == "ready") {
      ready();
    }
    if (menue_c == "test") {
      test();
    }

  }
}

//vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
void sync_time() {
  String usertime = "0";
  while(usertime == "0"){
    while (Serial.available()) {
      usertime = Serial.readStringUntil('\n');
    }                                                  //convertiert string hh:mm:ss
  }
  sync_time_ms(timeStringToMilliseconds(usertime));  // Todo Convertieterstring einfüge
}

void get_time() {
  print_time(get_time_in_ms());
}

void set_ID() { //gibt die ID in HEX am Serial aus; "q" zum abrechen 
  Serial.println("Ready to scan");
  bool set_ID_l = true;
  while (set_ID_l) {
    if (mfrc522.PICC_IsNewCardPresent()) {
      if (mfrc522.PICC_ReadCardSerial()) {
        uint64_t rfidID = 0;
        for (byte i = 0; i < mfrc522.uid.size; i++) {
          rfidID = (rfidID << 8) | mfrc522.uid.uidByte[i];
        }
        Serial.println(rfidID,HEX);
        set_ID_l = false;   //geht nach erkannter ID aus der funktion
      }
    }
    if (Serial.readStringUntil('\n') == "q"){set_ID_l = false;} //q um abzubrechen   TODO testen wie konstat des ist
  }
}

void read_log() {  //fügt endlog hinzu und gibt den inhalt zeile für zeie aus, danach wird das file mit gelöscht 
  //fügt am ende endlog im ID spalte hinzu
  myfile = SPIFFS.open(logpath,"a");
  myfile.printf("%d endlog %lu\n", station, get_time_in_ms());
  myfile.close();
  //gibt den ganzen log zeile für zeile aus
  myfile = SPIFFS.open(logpath,"r");
  while (myfile.position() < myfile.size()) {  
    Serial.println(myfile.readStringUntil('\n'));
  }
  myfile.close();
  //wartet auf bestätigungs wort und löscht den log
 // bool wait_for_delete =true;
 // while(wait_for_delete){
 //   while (Serial.available()) {        //ToDO schaun ob ma des löschen kann 
 //     if(Serial.readStringUntil('\n') == "delete"){
        SPIFFS.remove(logpath);
        Serial.println("deleted");
 //       wait_for_delete = false;
 //     }
 //   }
 // }
}
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

void ready() {
  // ready init start
  myfile = SPIFFS.open(logpath,"a");  //öffnet file in dem die logs geschrieben werden im anhang modus
  Serial.println("ready"); //Todo funktionen mist
  bool ready_l = true;
  // ready init stop
  while (ready_l) {
    while (Serial.available()) {        //ToDO schaun ob ma des löschen kann 
      String ready_c = Serial.readStringUntil('\n');
      if (ready_c == "start") {
        start();
      }
      if (ready_c == "q") {
        Serial.println("q");
        ready_l = false;
        myfile.close(); //schliest wieder das file für logs
      }
    }
  }
}

void start(){
  NFCEventTracker tracker; //map erstellen 
  unsigned long time = get_time_in_ms();
  Serial.print(station);
  Serial.print(" start ");
  Serial.println(time);
  myfile.print(station);
  myfile.print(" start ");
  myfile.println(time);
  bool start_l = true;
  while(start_l){
    
    // Renn aufzeichnung
    //Lichtschranke
    if (digitalRead(LS2)) {
      time = get_time_in_ms();
      if (!tracker.is_duplicate_event(1, time, 1000)) {
        Serial.print(station);
        Serial.print(" 1 ");
        Serial.println(time);
        myfile.print(station);
        myfile.print(" 1 ");
        myfile.println(time);
      }
    }
    //Card scan
    if (mfrc522.PICC_IsNewCardPresent()) {
      time = get_time_in_ms();
      if (mfrc522.PICC_ReadCardSerial()) {
        uint64_t rfidID = 0;
        for (byte i = 0; i < mfrc522.uid.size; i++) {
          rfidID = (rfidID << 8) | mfrc522.uid.uidByte[i];
        }
        if (!tracker.is_duplicate_event(rfidID, time, 1000)) {
          Serial.print(station);
          Serial.print(" ");
          Serial.print(rfidID,HEX);
          Serial.print(" ");
          Serial.println(time);
          myfile.print(station);
          myfile.print(" ");
          myfile.print(rfidID,HEX);
          myfile.print(" ");
          myfile.println(time);
        }
      }else{ //keine  ID gelesen
        if (!tracker.is_duplicate_event(0, time, 1000)) {
          Serial.print(station);
          Serial.print(" 0 ");
          Serial.println(time);
          myfile.print(station);
          myfile.print(" 0 ");
          myfile.println(time);
        }
      }
    }

    while (Serial.available()){       //ToDO schaun ob ma des löschen kann
      String start_c = Serial.readStringUntil('\n');
      if (start_c == "q"){
        time = get_time_in_ms();
        Serial.print(station);
          Serial.print(" stop ");
          Serial.println(time);
          myfile.print(station);
          myfile.print(" stop ");
          myfile.println(time);;
        //ToDO schaun ob ma des file schliesen muss
       // tracker.clear(); //map löschen
        start_l = false;
      }
    }
  }
}




//vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv 
unsigned long get_time_in_ms() {  //gibt die Uhrzeit in ms aus
  return time(&now) * 1000 + (millis() % 1000) - last_reset + time_by_user;
}

unsigned long timeStringToMilliseconds(String timeStr) {
  int hours, minutes, seconds;
  if (sscanf(timeStr.c_str(), "%d:%d:%d", &hours, &minutes, &seconds) == 3) {
    unsigned long totalMilliseconds = (hours * 3600UL + minutes * 60UL + seconds) * 1000UL;
    return totalMilliseconds;
  } else {
    // Rückgabe eines Fehlwertes, z.B. 0, wenn das Parsen fehlschlägt
    return 0;
  }
}

void sync_time_ms(unsigned long current_time_by_user) {  //Uhrzeit in ms einstellen
  last_reset = time(&now) * 1000 + (millis() % 1000);
  time_by_user = current_time_by_user;
}

void print_time(unsigned long ms) {  //Ausgabe format hh:mm:ss:msmsms
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
  Serial.println(seconds);
}

boolean InitalizeFileSystem() {  //vom SPIFFS Demoprogramm kopiert, Wird in der setup benötigt für File-Managmante
  bool initok = false;
  initok = SPIFFS.begin();
  if (!(initok))  // Format SPIFS, of not formatted. - Try 1
  {
    Serial.println("Format SPIFFS");
    SPIFFS.format();
    initok = SPIFFS.begin();
  }
  if (!(initok))  // Format SPIFS, of not formatted. - Try 2
  {
    SPIFFS.format();
    initok = SPIFFS.begin();
  }
  if (initok) {
    Serial.println("SPIFFS ist OK");
  } else {
    Serial.println("SPIFFS ist nicht OK");
  }
  return initok;
}








void test(){
  unsigned long jetzt=0;
  while (true){
    if ((get_time_in_ms()-jetzt) > 1000){
      Serial.println(get_time_in_ms());
      jetzt = get_time_in_ms();
    }
  }
}