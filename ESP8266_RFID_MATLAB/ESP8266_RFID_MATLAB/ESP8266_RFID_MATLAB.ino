
//For ESP8266
int value;
void setup()

{
Serial.begin(9600);
pinMode(2, OUTPUT);
}

void loop()
{
  if(Serial.available()>0)
  {
    value=Serial.read();
    if  (value == 1)           
    { 
    digitalWrite(2, HIGH);
    }
    if(value == 0)         
    { 
    digitalWrite(2, LOW);
    }
  }
}
