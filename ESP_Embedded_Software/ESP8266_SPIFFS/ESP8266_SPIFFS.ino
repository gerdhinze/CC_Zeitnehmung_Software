#include <SPI.h>
#include <FS.h>           // Nutze die SPIFFS library

File myfile;                   // erstelle ein SPIFFS Handling Variable

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
int zahl = 0;
void setup() 
{
  Serial.begin(115200);  
  SPI.begin();                     
  bool Result  = InitalizeFileSystem(); 
  if (!(SPIFFS.exists ("/usage_log.csv") ))  //Prüfe ob Datei usage_log.csv schon exisiert.
  {   
    myfile = SPIFFS.open("/usage_log.csv", "w");  //Öffne die Datei usage_log.csv im Root Verzeichnis zum schreiben (w – write)
    if (!myfile) 
      {
      Serial.println("Fehler beim schreiben der Datei");
      }
    Result = myfile.println("01.01.1980  12:00:00;Log cleared or deleted"); 
    Result = myfile.println("01.01.1980  12:00:01;First Entry, second Line");
    myfile.close();
  } else
  {
   SPIFFS.remove("/usage_log.csv");  //Lösche Datei  
   Serial.println("Datei usage_log.csv exisierte schon ! Sie wurde gelöscht.");
  }
}

void loop() 
{
  myfile = SPIFFS.open("/usage_log.csv", "r");  //Öffne die Datei usage_log.csv im Root Verzeichnis zum lesen (r - read)
  String content=myfile.readStringUntil('\n');
  Serial.println("Methode: readStringUntil:");
  while (myfile.position()<myfile.size())            // lese Dateiinhbalt Zeile für Zeile bis um Ende der Datei
        {
          content =myfile.readStringUntil('\n');
          Serial.println(content);
        } 
  int FileSize = myfile.size();
  myfile.close();
  Serial.print("Dateigroesse in Bytes:");           // gebe die aktuelle Dateigröße in Bytes aus
  Serial.println(FileSize);                                     // gebe die aktuelle Dateigröße in Bytes aus
 // delay (5000);
  yield();               // interne ESP8266 Funktionen aufrufen
  myfile = SPIFFS.open("/usage_log.csv", "a");  // Öffne Datei um Daten anzuhängen ! (a - append)
  myfile.println(zahl++);
  myfile.close();
  
}