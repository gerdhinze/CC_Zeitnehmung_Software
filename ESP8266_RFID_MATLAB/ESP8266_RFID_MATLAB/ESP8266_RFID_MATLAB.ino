//
////For ESP8266
//int value;
//void setup()
//
//{
//Serial.begin(9600);
//pinMode(2, OUTPUT);
//}
//
//void loop()
//{
//  if(Serial.available()>0)
//  {
//    value=Serial.read();
//    if  (value == 1)           
//    { 
//    digitalWrite(2, HIGH);
//    }
//    if(value == 0)         
//    { 
//    digitalWrite(2, LOW);
//    }
//  }
//}
int value = 0; // Variable für den Wert

void setup() {
  Serial.begin(115200); // Starten der seriellen Kommunikation mit 115200 Baud
}

void loop() {
  if (Serial.available() > 0) {
    char command = Serial.read(); // Befehl von MATLAB lesen
    
    if (command == 's') {
      // Wenn der Befehl 's' empfangen wird, senden Sie den Wert an MATLAB
      Serial.println(value);
    } else if (command == '0' || command == '1') {
      // Wenn der Befehl '0' oder '1' empfangen wird, setzen Sie den Wert entsprechend
      value = command - '0'; // '0' oder '1' in eine Zahl umwandeln (0 oder 1)
    }
  }
}
