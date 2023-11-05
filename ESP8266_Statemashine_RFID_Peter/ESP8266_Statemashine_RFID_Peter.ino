#ifndef STASSID
#endif


#include <sstream>
#include <string>

#include <ESP8266WiFi.h>  // we need wifi to get internet access
#include <time.h>         // for time() ctime()
#include <SPI.h>
#include <MFRC522.h>
#include <FS.h>  // Nutze die SPIFFS library

#define SS_PIN 4
#define RST_PIN 0
#define LS1 5
#define LS2 16

MFRC522 mfrc522(SS_PIN, RST_PIN);

/* Configuration of NTP */
#define MY_NTP_SERVER "at.pool.ntp.org"
#define MY_TZ "CET-1CEST,M3.5.0/02,M10.5.0/03"

/* Globals */
bool Wifi;
String WLAN_SSID;
String PW;   // your wifi password
time_t now;  // this are the seconds since Epoch (1970) - UTC
tm tm;       // the structure tm holds time information in a more convenient way
int ms;
unsigned long lastResetTime = 0;  // Variable zum Speichern der letzten Reset-Zeit
unsigned long realtime_set = 0;
uint64_t IDs[10];  //Array in dem die IDs gespeichert werden
int IDs_init_position = 2;
int maxarraysize = 40;
bool scanning = false;  // Variable, um den Scan-Status zu verfolgen um IDs ein
unsigned long race_start_time = 0;
File myfile;  // erstelle ein SPIFFS Handling Variable

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
  Wifi_setup();
  configTime(MY_TZ, MY_NTP_SERVER);  // --> Here is the IMPORTANT ONE LINER needed in your sketch!
}

void loop() {
  while (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    if (command == "set") {
      set_ID();
    }
    if (command == "set all") {
      Serial.println("set all");
      scanning = true;  // Starte den Scann-Status
      scanLoop();
    }
    if (command == "show") {
      show_IDs();
    }
    if (command == "clear") {
      clearAll();
      delete_all();
    }
    if (command == "race") {
      racemode();
    }
    if (command == "read") {
      read_files();
    }
    if (command == "init") {  //nur zum debugen
      InitalizeFileSystem();
    }
    if (command == "wifi") {
      wifimenue();
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

uint64_t get_ID() {  //gibt ID als uint64_t zurück. "q" um abzubrachen. bei abruch wird 0 zurück gegeben
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
        scan = false;      // Beende den Scan, wenn "q" eingegeben wird
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
    delay(1000);
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
  int defaultIDs[] = { 0, 1 };  // Die Standard-IDs, die nicht gelöscht werden sollen

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

void racemode() {
  //racemode init
  bool racemode = true;
  Serial.println("Racemode");
  timer_reset();
  creat_file_for_IDs();
  Serial.println("start or q");
  //racemode ready
  while (racemode) {
    while (Serial.available()) {
      String option = Serial.readStringUntil('\n');
      if (option == "q") {
        Serial.println("Racemode quit");
        racemode = false;
      }
      //start
      if (option == "start") {
        //start init
        bool racestart = true;
        race_start_time = get_time();
        Serial.print("start ");
        print_time(race_start_time);
        //startzeit wird in die Files geschriben
        std::string path;
        for (int i = 0; i < IDs_init_position; i++) {
          path = "/" + std::to_string(i) + ".csv";
          myfile = SPIFFS.open(path.c_str(), "a");
          myfile.print("race start time ");
          myfile.println(race_start_time);
          myfile.close();
        }

        // race aktiv
        while (racestart) {
          while (Serial.available()) {
            String stop_command = Serial.readStringUntil('\n');
            if (stop_command == "q") {
              Serial.println("stop");
              racestart = false;
              for (int i = 0; i < IDs_init_position; i++) {
                path = "/" + std::to_string(i) + ".csv";
                myfile = SPIFFS.open(path.c_str(), "a");
                myfile.print("race stop time ");
                myfile.println(get_time());
                myfile.close();
              }
            }
          }
          // RFID erkannt
          uint64_t rfidID = 0;
          if (mfrc522.PICC_IsNewCardPresent()) {
            if (mfrc522.PICC_ReadCardSerial()) {
              for (byte i = 0; i < mfrc522.uid.size; i++) {
                rfidID = (rfidID << 8) | mfrc522.uid.uidByte[i];
              }
              int position = position_im_array(IDs, rfidID);
              path = "/" + std::to_string(position) + ".csv";
              myfile = SPIFFS.open(path.c_str(), "a");
              myfile.println(get_time());
              myfile.close();
              Serial.print(position);
              Serial.print(" ");
              Serial.println(get_time());
              // RFID erkannt aber keine ID gelesen bzw nicht im IDs array
            } else {
              int position = position_im_array(IDs, rfidID);
              path = "/" + std::to_string(position) + ".csv";
              myfile = SPIFFS.open(path.c_str(), "a");
              myfile.println(get_time());
              myfile.close();
              Serial.print(position);
              Serial.print(" ");
              Serial.println(get_time());
            }
          }
          if (digitalRead(LS2)) {
            path = "/1.csv";
            myfile = SPIFFS.open(path.c_str(), "a");
            myfile.println(get_time());
            myfile.close();
            Serial.print("1");
            Serial.print(" ");
            Serial.println(get_time());
          }
        }
      }
    }
  }
}

void timer_reset() {
  lastResetTime = millis();
  time(&now);
  localtime_r(&now, &tm);
  realtime_set = tm.tm_sec * 1000 + tm.tm_min * 60 * 1000 + tm.tm_hour * 60 * 60 * 1000;
}

unsigned long get_time() {
  return realtime_set + millis() - lastResetTime;
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
}

int position_im_array(uint64_t arr[], uint64_t value) {
  for (int i = 0; i < IDs_init_position; i++) {
    if (arr[i] == value) {
      return i;  // Wert bereits vorhanden, gib die Position zurück
    }
  }
  return 0;
}

void creat_file_for_IDs() {
  std::string path;
  for (int i = 0; i < IDs_init_position; i++) {
    path = "/" + std::to_string(i) + ".csv";
    myfile = SPIFFS.open(path.c_str(), "a");
    myfile.print("Race init ");
    myfile.println(get_time());
    myfile.println(IDs[i], HEX);
    myfile.close();
    Serial.println(path.c_str());
  }
}

void read_times(int ID_position) {
  std::string path;
  path = "/" + std::to_string(ID_position) + ".csv";
  myfile = SPIFFS.open(path.c_str(), "r");
  while (myfile.position() < myfile.size()) {  // lese Dateiinhbalt Zeile für Zeile bis um Ende der Datei
    Serial.println(myfile.readStringUntil('\n'));
  }
  myfile.close();
}

bool delete_file(int ID_position) {
  std::string path;
  path = "/" + std::to_string(ID_position) + ".csv";
  // check if file exists
  if (SPIFFS.exists(path.c_str())) {  //Prüfe ob Datei usage_log.csv schon exisiert.
    SPIFFS.remove(path.c_str());      //Lösche Datei
    Serial.print(path.c_str());
    Serial.println(" wurde gelöscht.");
    return true;
  } else {
    return false;
  }
}

void delete_all() {
  for (int i = 0; i < maxarraysize; i++) {
    delete_file(i);
  }
}

bool existing_files() {
  bool exists = false;
  std::string path;
  for (int i = 0; i < maxarraysize; i++) {
    path = "/" + std::to_string(i) + ".csv";
    // check if file exists
    if (SPIFFS.exists(path.c_str())) {
      exists = true;
      Serial.print(i);
      Serial.print(" = ");
      Serial.println(path.c_str());
    }
  }
  return exists;
}

void read_files() {
  bool selectable = false;
  if (existing_files()) {
    selectable = true;
    Serial.println("select or q");
    while (selectable) {
      while (Serial.available()) {
        String selected = Serial.readStringUntil('\n');
        if (selected == "q") {
          Serial.println("exit");
          selectable = false;

        } else {
          read_times(selected.toInt());
        }
      }
    }
  } else {
    Serial.println("no exisitng files.");
  }
}

void Wifi_setup() {
  // Netzwerk starten
  delay(5000);
  Serial.println();
  Serial.println("Is WiFi setup available? (y/n)");
  bool wifisetup = true;

  while (wifisetup) {
    while (Serial.available()) {
      String command = Serial.readStringUntil('\n');
      if (command == "y") {
        Wifi = true;

        // Überprüfe, ob die Datei wifi_data.txt existiert
        if (SPIFFS.exists("wifi_data.txt")) {
          // Datei existiert, lese WLAN-Einstellungen aus der Datei
          myfile = SPIFFS.open("wifi_data.txt", "r");
          WLAN_SSID = myfile.readStringUntil('\n');
          PW = myfile.readStringUntil('\n');
          myfile.close();

          Serial.println("Current WiFi settings:");
          Serial.print("WLAN_SSID: ");
          Serial.println(WLAN_SSID);
          Serial.print("Password: ");
          Serial.println(PW);
          Serial.println("Change WiFi settings? (y/n)");

          bool wait_for_userinput = true;
          while (wait_for_userinput) {
            while (Serial.available()) {
              String userinput = Serial.readStringUntil('\n');
              if (userinput == "y") {
                set_wifi_settings();
                wait_for_userinput = false;
              }
              if (userinput == "n") {
                wait_for_userinput = false;
              }
            }
          }
        } else {
          // Datei wifi_data.txt existiert nicht, führe die Einrichtung der WLAN-Einstellungen durch
          set_wifi_settings();
        }

        connect_wifi();  // Verbinde zum WLAN
        wifisetup = false;
      }
      if (command == "n") {
        Wifi = false;
       // setTimeManually(); //Todo
        wifisetup = false;
      }
    }
  }
}

void connect_wifi() {
  WiFi.persistent(false);
  WLAN_SSID.trim();  //ohne trim problem bei wlansettings aus dem file lesen
  PW.trim();
  Serial.println(WLAN_SSID);
  Serial.println(PW);
  WiFi.mode(WIFI_STA);
  WiFi.begin(WLAN_SSID, PW);
  delay(2000);
  while (WiFi.status() != WL_CONNECTED) {
    delay(200);
    Serial.print(".");
  }
  if (WiFi.status() == WL_CONNECTED) {
    Serial.println("Connected");
  }
}

void set_wifi_settings() {
  Serial.println("Enter WLAN SSID ");
  bool wait_for_SSID = true;
  while (wait_for_SSID) {
    while (Serial.available()) {
      WLAN_SSID = Serial.readStringUntil('\n');
      if (WLAN_SSID != "") {
        wait_for_SSID = false;
      }
    }
  }
  Serial.println("Enter Passwort ");
  bool wait_for_PW = true;
  while (wait_for_PW) {
    while (Serial.available()) {
      PW = Serial.readStringUntil('\n');
      if (PW != "") {
        wait_for_PW = false;
      }
    }
  }
  Serial.println("New WIFI settings are:");
  Serial.print("WLAN SSID: ");
  Serial.println(WLAN_SSID);
  Serial.print("Passwort: ");
  Serial.println(PW);
  Serial.println("1 Change");
  Serial.println("2 Use and save");
  Serial.println("3 Use and don't save");
  bool wait_for_user = true;
  while (wait_for_user) {
    while (Serial.available()) {
      String user_choice = Serial.readStringUntil('\n');
      if (user_choice == "1") {
        wait_for_user = false;
        set_wifi_settings();
      }
      if (user_choice == "2") {
        myfile = SPIFFS.open("wifi_data.txt", "w");
        myfile.println(WLAN_SSID);
        myfile.println(PW);
        myfile.close();
        wait_for_user = false;
      }
      if (user_choice == "3") {
        wait_for_user = false;
      }
    }
  }
}

void delete_wifi_settings() {
  if (SPIFFS.exists("wifi_data.txt")) {
    SPIFFS.remove("wifi_data.txt");
    Serial.println("Wifi data deleted.");
  } else {
    Serial.println("No Wifi data saved.");
  }
}

void wifimenue() {
  bool wifi_menue = true;
  Serial.println("Options:");
  Serial.println("change");
  Serial.println("delete");
  Serial.println("show");
  while (wifi_menue) {
    while (Serial.available()) {
      String wifi_command = Serial.readStringUntil('\n');
      if (wifi_command == "delete") {
        delete_wifi_settings();
        wifi_menue = false;
      }
      if (wifi_command == "change") {
        set_wifi_settings();
        connect_wifi();
        wifi_menue = false;
      }
      if (wifi_command == "show") {
        Serial.println("Current WiFi settings:");
        Serial.print("WLAN_SSID: ");
        Serial.println(WLAN_SSID);
        Serial.print("Password: ");
        Serial.println(PW);
        if (SPIFFS.exists("wifi_data.txt")) {
          myfile = SPIFFS.open("wifi_data.txt", "r");
          while (myfile.position() < myfile.size()) {  // lese Dateiinhalt Zeile für Zeile bis um Ende der Datei
            Serial.println(myfile.readStringUntil('\n'));
          }
          myfile.close();
        } else {
          Serial.print("No data saved");
        }
        wifi_menue = false;
      }
    }
  }
}

