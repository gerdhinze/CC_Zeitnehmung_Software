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
#define LS 16   //D0
#define LED1 15 //D8
#define LED2 2  //D4
#define LED3 5  //D2


//Globals
File myfile;                       // erstelle ein SPIFFS Handling Variable
MFRC522 mfrc522(SS_PIN, RST_PIN);  //NFC Reader
time_t now;                        // this are the seconds since Epoch (1970) - UTC
tm tm;                             // the structure tm holds time information in a more convenient way
unsigned long last_reset = 0;
unsigned long time_by_user = 0;
int station = 2;
String logpath = "log.csv";
bool logiswritten;

void setup() {
  Serial.begin(115200);
  SPI.begin();
  mfrc522.PCD_Init();
  InitalizeFileSystem();
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
}

void loop() {
  led_status(3);
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
    if (menue_c == "delete_log"){
      delete_log();
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
    led_status(5);
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
  led_status(7);
  while (set_ID_l) {
    if (mfrc522.PICC_IsNewCardPresent()) {
      if (mfrc522.PICC_ReadCardSerial()) {
        uint64_t rfidID = 0;
        for (byte i = 0; i < mfrc522.uid.size; i++) {
          rfidID = (rfidID << 8) | mfrc522.uid.uidByte[i];
        }
        String id_string = String("id") + String(rfidID, HEX);
        Serial.println(id_string);
        set_ID_l = false;   //geht nach erkannter ID aus der funktion
      }
    }
    if (Serial.readStringUntil('\n') == "q"){set_ID_l = false;} //q um abzubrechen   TODO testen wie konstat des ist
  }
}

void read_log() {  //fügt endlog hinzu und gibt den inhalt zeile für zeie aus, danach wird das file mit gelöscht 
  if (logiswritten){
    //fügt am ende endlog im ID spalte hinzu
    myfile = SPIFFS.open(logpath,"a");
    myfile.printf("%d endlog %lu\n", station, get_time_in_ms());
    myfile.close();
    logiswritten = false;
  }
  if (SPIFFS.exists(logpath)){
    //gibt den ganzen log zeile für zeile aus
    myfile = SPIFFS.open(logpath,"r");
    while (myfile.position() < myfile.size()) {  
      Serial.println(myfile.readStringUntil('\n'));
    }
    myfile.close();
  }
  else{
    Serial.printf("%d nolog %lu\n", station, get_time_in_ms());
  }

}

void delete_log(){
  if (SPIFFS.exists(logpath)){
    SPIFFS.remove(logpath);
    Serial.println("deleted");
  }else{
    Serial.println("nolog");
  }

}

void ready() {
  // ready init start
  myfile = SPIFFS.open(logpath,"a");  //öffnet file in dem die logs geschrieben werden im anhang modus
  logiswritten = true;  
  Serial.println("ready"); 
  bool ready_l = true;
  // ready init stop
  while (ready_l) {
    led_status(2);
    while (Serial.available()) {       
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
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

void start(){
  NFCEventTracker tracker; //map erstellen 
  unsigned long time = get_time_in_ms();
  String event = String("ld")+String(station)+" "+String("start")+" "+String(time);
  Serial.println(event);
  myfile.println(event);
  bool start_l = true;
  led_status(1);
  while(start_l){
  // Renn aufzeichnung
    //Lichtschranke
    if (digitalRead(LS)) {
      time = get_time_in_ms();
      if (!tracker.is_duplicate_event(1, time, 1000)) {
        String event = String("ld") + String(station)+" "+String(1)+" "+String(time);
        Serial.println(event);
        myfile.println(event);
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
          String event = String("ld")+String(station)+" "+String(rfidID,HEX)+" "+String(time);
          Serial.println(event);
          myfile.println(event);
        }
      }else{ //keine  ID gelesen
        if (!tracker.is_duplicate_event(0, time, 1000)) {
          String event = String("ld")+String(station)+" "+String(0)+" "+String(time);
          Serial.println(event);
          myfile.println(event);
        }
      }
    }

    while (Serial.available()){      
      String start_c = Serial.readStringUntil('\n');
      if (start_c == "q"){
        time = get_time_in_ms();
          String event = String("ld") + String(station)+" "+String("stop")+" "+String(time);
          Serial.println(event);
          myfile.println(event);
        start_l = false;
      }
    }
  }
}


unsigned long get_time_in_ms() {  //gibt die Uhrzeit in ms aus
  return millis() - last_reset + time_by_user;
}

unsigned long timeStringToMilliseconds(String timeStr) {
  int hours, minutes, seconds;
  if (sscanf(timeStr.c_str(), "%2d:%2d:%2d", &hours, &minutes, &seconds) == 3) {
    unsigned long totalMilliseconds = (hours * 3600UL + minutes * 60UL + seconds) * 1000UL;
    return totalMilliseconds;
  } else {
    // Rückgabe eines Fehlwertes, z.B. 0, wenn das Parsen fehlschlägt
    return 0;
  }
}

void sync_time_ms(unsigned long current_time_by_user) {  //Uhrzeit in ms einstellen
  last_reset =  millis();
  time_by_user = current_time_by_user;
}

void print_time(unsigned long ms) {  //Ausgabe format hh:mm:ss
  // Berechne die Stunden, Minuten, Sekunden
  unsigned long hours = ms / 3600000;
  ms = ms % 3600000;
  unsigned long minutes = ms / 60000;
  ms = ms % 60000;
  unsigned long seconds = ms / 1000;
  // Gib das formatierte Ergebnis aus
   // Erstelle einen String für die formatierte Ausgabe
  String formatted_time = String("t") + (hours < 10 ? "0" : "") + String(hours) + ":" +
                          (minutes < 10 ? "0" : "") + String(minutes) + ":" +
                          (seconds < 10 ? "0" : "") + String(seconds);

  // Sende den formatierten String an den Serial Monitor
  Serial.println(formatted_time);
}

boolean InitalizeFileSystem() {  //vom SPIFFS Demoprogramm kopiert, Wird in der setup benötigt für File-Managmante
  bool initok = false;
  initok = SPIFFS.begin();
  if (!(initok))  // Format SPIFS, of not formatted. - Try 1
  {
  //  Serial.println("Format SPIFFS");
    SPIFFS.format();
    initok = SPIFFS.begin();
  }
  if (!(initok))  // Format SPIFS, of not formatted. - Try 2
  {
    SPIFFS.format();
    initok = SPIFFS.begin();
  }
  if (initok) {
  //  Serial.println("SPIFFS ist OK");
  } else {
  //  Serial.println("SPIFFS ist nicht OK");
  }
  return initok;
}

void led_status(int status){
  digitalWrite(LED1, LOW);
  digitalWrite(LED2, LOW);
  digitalWrite(LED3, LOW);

  switch(status){
    case 1:
      digitalWrite(LED1, HIGH);
      break;
    case 2:
      digitalWrite(LED2, HIGH);
      break;
    case 3:
      digitalWrite(LED3, HIGH);
      break;
    case 4:
      digitalWrite(LED1, HIGH);
      digitalWrite(LED2, HIGH);
      break;
    case 5:
      digitalWrite(LED1, HIGH);
      digitalWrite(LED3, HIGH);
      break;
    case 6:
      digitalWrite(LED2, HIGH);
      digitalWrite(LED3, HIGH);
      break;
    case 7:
      digitalWrite(LED1, HIGH);
      digitalWrite(LED2, HIGH);
      digitalWrite(LED3, HIGH);
      break;
  }
}


//vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv



void test(){
  unsigned long jetzt=0;
  bool test = true;
  while (test){
    led_status(3);
    while (Serial.available()) {
      String test_c = Serial.readStringUntil('\n');
      if (test_c == "sync_time") { //fertig
        sync_time_test();
      }
      if (test_c == "get_time") { //fertig
        get_time();
      }
      if (test_c == "set_ID") { //fertig
        set_ID(); //gibt nur die ID zurück
      }
      if (test_c == "read_log") {
        read_log(); 
      }
      if (test_c == "delete_log"){
        delete_log();
      }
      if (test_c == "ready") {
        ready();
      }
      if (test_c == "q") {
        test = false;
      }
    }
  }
}

sync_time_test();

int random(int min, int max) {
    // Initialisiere den Zufallszahlengenerator mit der aktuellen Zeit
    srand(time(0));

    // Generiere eine zufällige Zahl zwischen 1 und 1000
    int random_number = rand() % max + min;

    return random_number;
}