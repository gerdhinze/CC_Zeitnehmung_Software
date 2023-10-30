#ifndef STASSID
#define WLAN_SSID "HUAWEI_B535_9009"                            // set your SSID
#define PW  ""                        // set your wifi password
#endif

/* Necessary Includes */
#include <ESP8266WiFi.h>            // we need wifi to get internet access
#include <time.h>                   // for time() ctime()
#include <SPI.h>
#include <MFRC522.h>

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

void setup() 
{
  Serial.begin(115200);
  SPI.begin();
  mfrc522.PCD_Init();
  Serial.println("\nNTP TZ DST - bare minimum");

  configTime(MY_TZ, MY_NTP_SERVER); // --> Here is the IMPORTANT ONE LINER needed in your sketch!

  // start network
  WiFi.persistent(false);
  WiFi.mode(WIFI_STA);
  WiFi.begin(WLAN_SSID, PW);
  while (WiFi.status() != WL_CONNECTED) 
  {
    delay(200);
    Serial.print ( "." );
  }

  pinMode(LS1, INPUT);
  pinMode(LS2, INPUT);
}

void loop() 
{
  ms++;
  if(ms > 1000)
  {
    ms = 0;
  }
  delay(1); 

  if (mfrc522.PICC_IsNewCardPresent()) 
  {
    if (mfrc522.PICC_ReadCardSerial()) 
    {
      Serial.print("Event 1: NCF-Tag gelesen mit ID ");
      for (byte i = 0; i < mfrc522.uid.size; i++) {
        Serial.print(mfrc522.uid.uidByte[i], HEX);
        Serial.print(" ");
      }
      showTime();
      Serial.println();
    }
    else
    {
      Serial.print("Event 1: NCF-Tag ohne ID gelesen ");
      showTime();
      Serial.println();
    }
  }

  bool value_LS1 = digitalRead(LS1);
  bool value_LS2 = digitalRead(LS2);

  if (value_LS1) {
    Serial.print("Event 2: Lichtschranke 1 ausgelöst ");
    showTime();
    Serial.println();
  }

  if (value_LS2) {
    Serial.print("Event 3: Lichtschranke 2 ausgelöst ");
    showTime();
    Serial.println();
  }
}

void showTime() 
{
  time(&now);                       // read the current time
  localtime_r(&now, &tm);           // update the structure tm with the current time

  Serial.print("@ ");
  Serial.print(tm.tm_hour);         // hours since midnight  0-23
  Serial.print(":");
  Serial.print(tm.tm_min);          // minutes after the hour  0-59
  Serial.print(":");
  Serial.print(tm.tm_sec);          // seconds after the minute  0-61*
  Serial.print(":");
  Serial.print(ms);                 // millisec
  Serial.println();
}
