// pin assignments
#include "GloveConfig.h"


void setup()
{
  pinMode(VIBE_PIN, OUTPUT);
  Serial.begin(9600);
}

void loop()
{
  float ax = analogRead(ACCEL_X);
  float ay = analogRead(ACCEL_Y);
  float az = analogRead(ACCEL_Z);
  
  float f1 = analogRead(FLEX_1);
  float f2 = analogRead(FLEX_2);
  float f3 = analogRead(FLEX_3);
  
  int t1 = digitalRead(TOUCH_1);
  int t2 = digitalRead(TOUCH_2);
  int t3 = digitalRead(TOUCH_3);
  int t4 = digitalRead(TOUCH_4);
  
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
}
