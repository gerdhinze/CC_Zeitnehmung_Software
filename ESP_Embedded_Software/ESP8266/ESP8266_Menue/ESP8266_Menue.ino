//////////////////////////////////////////////////////////////////
//In diesem Programm komuniziert der ESP mit dem PC über Serial //
//Sämptiche "Codewörter" wurden mit der GUI des PCs abgestimmt  //
//////////////////////////////////////////////////////////////////


//Biblioteken für den NFCEventTracker 
#include <sstream>
#include <string>
#include <map>
//Biblioteken für NFC-Reader
#include <SPI.h>
#include <MFRC522.h>  //NFC Reader
//Bibliotek für DataLog
#include <FS.h>       // Nutze die SPIFFS library
//Bibliotek für einfachere Zeitformatierung
#include <time.h>  // for time() ctime()
// defines für die Pins
#define SS_PIN 4
#define RST_PIN 0
#define LS 16   //D0
#define LED1 15 //D8
#define LED2 2  //D4
#define LED3 5  //D2

//In der Klasser NFCEventTracker ist die Funktion "is_duplicate_event" die bei einem Eintrag in den Log bzw beim Seriel senden zum PC nur das erstemal sendet. Somit wird der Log-Speicher nicht so schnell voll und es sind weniger Daten zu verarbeiten. 
//So wird ein Event (Lichtschranke oder NFC ID) nur beim ersten eintreten und erst nach der freiwählbaren delaytime wieder gesendet. 
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

// Deklaration der Funktionen vor ihrer Verwendung
unsigned long timeStringToMilliseconds(String timeStr);
void sync_time_ms(unsigned long current_time_by_user);
unsigned long get_time_in_ms();
void print_time(unsigned long ms);
boolean InitalizeFileSystem();

//Globals
//Stationsnummer wir im Log und Seriel mitgesendet. Wichtig für gültige Daten. Sonst funktioniert der Algorytmus für Zwischenzeizen nich. Muss für jede Station eingestellt werden
int station = 3;
//Für Log
File myfile;                       //erstelle ein SPIFFS Handling Variable
String logpath = "log.csv";		   //Path für Log	
bool logiswritten;				   //damit man erkennt ob der Log beschrieben wurde 
//SPI für NFC Reader
MFRC522 mfrc522(SS_PIN, RST_PIN);  
//für Zeitformatierung
time_t now;                        // this are the seconds since Epoch (1970) - UTC
tm tm;                             // the structure tm holds time information in a more convenient way
unsigned long last_reset = 0;
unsigned long time_by_user = 0;


void setup() {
  Serial.begin(115200);
  //NFC-Reader set-up
  SPI.begin();
  mfrc522.PCD_Init();
  mfrc522.PCD_SetAntennaGain(mfrc522.RxGain_max); //damit der NFC-Reader die maximale leistung und reichweiite hat
  //Filesystem für Log
  InitalizeFileSystem();
  //LEDs um zu erkennen in welchen Satus sich der ESP befindet
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(LED3, OUTPUT);
}

// in der Mainloop wartet der ESP auf Befehle vom PC und führt demenstrechend Funktionen aus 
void loop() {
  led_status(3); //LED rot
  while (Serial.available()) {
    String menue_c = Serial.readStringUntil('\n');
    if (menue_c == "sync_time") { //hiermit lässt sich die Zeit am ESP einstellen. Erwartet anschliesend die Zeit im Format HH:MM:SS oder "q" um abzubrechen 
	  sync_time();
    }
    if (menue_c == "get_time") { //gibt die Zeit vom ESP im FormatHH:MM:SS zurück. Dient zur kontrolle ob das Sycronisieren der Zeit funktioniert hat
      get_time();
    }
    if (menue_c == "set_ID") { 
      set_ID(); //gibt die ID des NFC-Tags zurück der danach vom Reader gelesen wird. Bleibt in der Schleife bis gelesen wird oder vom PC "q" kommt um Abzubrechen. Alle LEDs leucheten 
    }
    if (menue_c == "read_log") { //Gib den Log über Seriel aus oder "noLog" wenn keiner vohanten ist 
      read_log(); 
    }
    if (menue_c == "delete_log"){ //Löscht den Log und gibt die bestätigung über Seriel aus bzw "noLog" wenn keiner vorhanden ist. Sollte nach jedem Rennen gemacht werden.
      delete_log();
    }
    if (menue_c == "ready") { // geht in den Readystat und bleibt dort. Gelbe LED leuchtet. Files für Log werden vorbereitet. Weitere Optionen sind "start" oder "q" um zurück in die Mainloop zu kommen 
      ready();
    }
  }
}

//Readystate erstellt bzw öffnet das Log-File im Apendmodus und wartetauf "start" oder "q" zum Mainloop vom PC. Gelbe LED Leuchtet. Muss in einem zwischen schritt vor dem Start passiern da das File öffnen etwas länger dauert  
void ready() {
  // ready init 
  myfile = SPIFFS.open(logpath,"a");  //öffnet file in dem die logs geschrieben werden im append Modus
  logiswritten = true;  
  Serial.println("iris ready"); 
  bool ready_l = true;

  while (ready_l) {
    led_status(2);
    while (Serial.available()) {       
      String ready_c = Serial.readStringUntil('\n');
      if (ready_c == "start") {		
        start();
      }
      if (ready_c == "q") {
        myfile.close(); //schliest wieder das file für logs
        Serial.println("qVorgang gestoppt");
        ready_l = false;
      }
    }
  }
}
// Start für das Rennen. grüne LED leuchtet. Alle Events werden abhängig voind der "is_duplicate_event" in den Log gespeichet bzw an den PC gesendet, am Anfang ein Start, und nach "q" zum Beenden ein stop. Immer im Format '"Station" "ID" "Zeit in ms"\n'. 
// Start und Stop stehen an der ID Stelle. ID 1 ist die Lichtschranke und ID 0 ist wenn keine ID gelesn wurde
void start(){   
  NFCEventTracker tracker; //map erstellen um zu wissen welche IDs bereits gelesen wurden 
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
        Serial.println("qVorgang gestoppt");
        start_l = false;
      }
    }
  }
}

//Sync Time nimmt die Zeit vom PC und aktualisiert die Zeit am ESP
void sync_time() {	
  String usertime = "0";
  while(usertime == "0"){
    led_status(5);
    while (Serial.available()) {
      usertime = Serial.readStringUntil('\n');
    }                                                  
  }
  sync_time_ms(timeStringToMilliseconds(usertime)); //convertiert string hh:mm:ss
}

// Sendet die Zeit vom ESP and den PC
void get_time() {
  print_time(get_time_in_ms());
}

//gibt die ID in HEX am Serial aus; "q" zum abrechen 
void set_ID() { 
  led_status(7);
  Serial.println("idReady to scan");
  bool set_ID_l = true;
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
    if (Serial.readStringUntil('\n') == "q"){set_ID_l = false;} //q um abzubrechen   
  }
}

//fügt endlog hinzu und gibt den inhalt zeile für zeie aus, danach wird das File mit gelöscht 
void read_log() {  
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

//Löscht den Log damit wieder Speicher freigegeben wird 
void delete_log(){ 
  if (SPIFFS.exists(logpath)){
    SPIFFS.remove(logpath);
    Serial.println("deleted");
  }else{
    Serial.println("nolog");
  }

}

//gibt die Uhrzeit in ms zurück
unsigned long get_time_in_ms() {  
  return millis() - last_reset + time_by_user;
}

//nimmt einen Zeintstring im Format HH:MM:SS und gibt ihn in ms zurück
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

//Uhrzeit in ms einstellen
void sync_time_ms(unsigned long current_time_by_user) {  
  last_reset =  millis();
  time_by_user = current_time_by_user;
}

//Ausgabe der Zeit im Format hh:mm:ss
void print_time(unsigned long ms) {  
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

//vom SPIFFS Demoprogramm kopiert, Wird in der setup benötigt für File-Managmante
boolean InitalizeFileSystem() {  
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
  
  return initok;
}

// Für einfgachere Steuerung der LEDs 
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
