#include <SPI.h>
#include <MFRC522.h>
#include <EEPROM.h>

#define SS_PIN 4
#define RST_PIN 0
#define LS1 5
#define LS2 16

MFRC522 mfrc522(SS_PIN, RST_PIN);

unsigned long lastResetTime = 0;
bool resetRequested = false;

const int eventBufferSize = 256;
char eventBuffer[eventBufferSize];

int address = 0;

void setup() {
  Serial.begin(9600);
  SPI.begin();
  mfrc522.PCD_Init();
  pinMode(LS1, INPUT);
  pinMode(LS2, INPUT);
  lastResetTime = millis();
}

void resetTimer() {
  lastResetTime = millis();
  Serial.println("Timer zurückgesetzt");
}

void printTimeDifference(unsigned long milliseconds) {
  unsigned long seconds = (milliseconds / 1000) % 60;
  unsigned long minutes = (milliseconds / (1000 * 60)) % 60;
  unsigned long hours = (milliseconds / (1000 * 60 * 60)) % 24;
  unsigned long remainingMilliseconds = milliseconds % 1000;
  
  Serial.print(hours);
  Serial.print("h ");
  Serial.print(minutes);
  Serial.print("min ");
  Serial.print(seconds);
  Serial.print("sek ");
  Serial.print(remainingMilliseconds);
  Serial.print("ms");
}

void saveEventToEEPROM(const char* event) {
  int length = strlen(event);
  if (length + 1 <= eventBufferSize - address) {
    for (int i = 0; i < length; i++) {
      EEPROM.write(address++, event[i]);
    }
    EEPROM.write(address++, '\0');
    EEPROM.commit();
  } else {
    Serial.println("EEPROM voll, Event konnte nicht gespeichert werden.");
    
    // Lösche den ältesten Event, um Platz für neue Events zu schaffen
    int eventLength = 0;
    int currentAddress = 0;
    while (currentAddress < address && eventLength == 0) {
      char currentChar = EEPROM.read(currentAddress++);
      if (currentChar == '\0') {
        eventLength = currentAddress;
      }
    }
    
    if (eventLength > 0) {
      for (int i = 0; i < address - eventLength; i++) {
        char currentChar = EEPROM.read(eventLength + i);
        EEPROM.write(i, currentChar);
      }
      address -= eventLength;
      EEPROM.commit();
      
      // Versuche, das Event erneut zu speichern
      saveEventToEEPROM(event);
    }
  }
}

void readEventsFromEEPROM() {
  Serial.println("Gespeicherte Events:");
  int currentAddress = 0;
  while (currentAddress < address) {
    char currentChar = EEPROM.read(currentAddress++);
    if (currentChar == '\0') {
      Serial.println();
    } else {
      Serial.print(currentChar);
    }
  }
}

void clearEEPROM() {
  for (int i = 0; i < eventBufferSize; i++) {
    EEPROM.write(i, 0);
  }
  EEPROM.commit();
  address = 0;
  Serial.println("EEPROM gelöscht.");
}

void loop() {
  unsigned long currentTime = millis();

  if (resetRequested) {
    resetTimer();
    resetRequested = false;
  }

  if (mfrc522.PICC_IsNewCardPresent()) {
    if (mfrc522.PICC_ReadCardSerial()) {
      char event[100];
      snprintf(event, 100, "Event 1: NCF-Tag gelesen mit ID - Zeit seit dem letzten Reset: ");
      unsigned long timeDifference = currentTime - lastResetTime;
      int hours = timeDifference / (1000 * 60 * 60);
      int minutes = (timeDifference / (1000 * 60)) % 60;
      int seconds = (timeDifference / 1000) % 60;
      int milliseconds = timeDifference % 1000;
      int len = strlen(event);
      snprintf(event + len, 100 - len, "%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds);
      Serial.println(event);
      saveEventToEEPROM(event);
    }
  }

  bool value_LS1 = digitalRead(LS1);
  bool value_LS2 = digitalRead(LS2);

  if (value_LS1) {
    char event[100];
    snprintf(event, 100, "Event 2: Lichtschranke 1 ausgelöst - Zeit seit dem letzten Reset: ");
    unsigned long timeDifference = currentTime - lastResetTime;
    int hours = timeDifference / (1000 * 60 * 60);
    int minutes = (timeDifference / (1000 * 60)) % 60;
    int seconds = (timeDifference / 1000) % 60;
    int milliseconds = timeDifference % 1000;
    int len = strlen(event);
    snprintf(event + len, 100 - len, "%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds);
    Serial.println(event);
    saveEventToEEPROM(event);
  }

  if (value_LS2) {
    char event[100];
    snprintf(event, 100, "Event 3: Lichtschranke 2 ausgelöst - Zeit seit dem letzten Reset: ");
    unsigned long timeDifference = currentTime - lastResetTime;
    int hours = timeDifference / (1000 * 60 * 60);
    int minutes = (timeDifference / (1000 * 60)) % 60;
    int seconds = (timeDifference / 1000) % 60;
    int milliseconds = timeDifference % 1000;
    int len = strlen(event);
    snprintf(event + len, 100 - len, "%02d:%02d:%02d.%03d", hours, minutes, seconds, milliseconds);
    Serial.println(event);
    saveEventToEEPROM(event);
  }

  while (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    if (command == "reset") {
      resetRequested = true;
    } else if (command == "read") {
      readEventsFromEEPROM();
    } else if (command == "clear") {
      clearEEPROM();
    }
  }
}
