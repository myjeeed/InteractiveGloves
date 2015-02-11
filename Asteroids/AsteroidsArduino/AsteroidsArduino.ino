// pin assignments

// digital output
const int vibePin = 4;

// digital inputs
const int touch1 = 9;
const int touch2 = 12;
const int touch3 = 11;
const int touch4 = 10;

// analog inputs
const int flex1 = 5;
const int flex2 = 4;
const int flex3 = 3;

const int accelX = 0;
const int accelY = 1;
const int accelZ = 2;

int vibeStart;

void setup()
{
  vibeStart = 0;
  pinMode(vibePin, OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  float ax = analogRead(accelX);
  float ay = analogRead(accelY);
  float az = analogRead(accelZ);
  
  float f1 = analogRead(flex1);
  float f2 = analogRead(flex2);
  float f3 = analogRead(flex3);
  
  int t1 = digitalRead(touch1);
  int t2 = digitalRead(touch2);
  int t3 = digitalRead(touch3);
  int t4 = digitalRead(touch4);
  
  String str = "";
  str += ax;
  str += ",";
  str += ay;
  str += ",";
  str += az;
  str += ",";
  str += f1;
  str += ",";
  str += f2;
  str += ",";
  str += f3;
  str += ",";
  str += t1;
  str += ",";
  str += t2;
  str += ",";
  str += t3;
  str += ",";
  str += t4;
  
  Serial.println(str);

  char x = Serial.read();
  if (x == 'v') {
    digitalWrite(vibePin, HIGH);
    vibeStart = millis();
  }
  
  if (millis() - vibeStart > 200) {
    digitalWrite(vibePin, LOW);
    vibeStart = 0;
  }
}
