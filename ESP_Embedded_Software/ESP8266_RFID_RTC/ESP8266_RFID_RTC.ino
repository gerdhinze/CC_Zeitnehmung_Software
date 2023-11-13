#ifndef STASSID
#define WLAN_SSID "HUAWEI_B535_9009"                            // set your SSID
#define PW  ""                        // set your wifi password
#endif

/* Configuration of NTP */
#define MY_NTP_SERVER "at.pool.ntp.org"           
#define MY_TZ "CET-1CEST,M3.5.0/02,M10.5.0/03"   

/* Necessary Includes */
#include <ESP8266WiFi.h>            // we need wifi to get internet access
#include <time.h>                   // for time() ctime()

/* Globals */
time_t now;                         // this are the seconds since Epoch (1970) - UTC
tm tm;                              // the structure tm holds time information in a more convenient way
int ms;

void showTime() 
{
  time(&now);                       // read the current time
  localtime_r(&now, &tm);           // update the structure tm with the current time

  Serial.print("Real Time: ");
  Serial.print(tm.tm_hour);         // hours since midnight  0-23
  Serial.print(":");
  Serial.print(tm.tm_min);          // minutes after the hour  0-59
  Serial.print(":");
  Serial.print(tm.tm_sec);          // seconds after the minute  0-61*
  Serial.print(":");
  Serial.print(ms);          // millisec
  
  Serial.println();
}

void setup() 
{
  Serial.begin(115200);
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
}

void loop() 
{
  ms++;
  if(ms > 1000)
  {
    ms = 0;
  }
  showTime();
  delay(1); 
}
