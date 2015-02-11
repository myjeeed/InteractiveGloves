float xZero = 500, yZero = 570, zZero = -430;
float xAcc = 0, yAcc = 0, zZAcc = 0;
float roll = 0, pitch = 0, yaw = 0;

float scale = 10.0;
float avgBend = 0;
float threshold = 999999;

void setup()
{
  Serial.begin(9600);
  
}

boolean firstRead = true;
boolean calibrated = false;

void loop()
{
  float xAcc = (analogRead(0) - xZero)/scale;
  float yAcc = (analogRead(1) - yZero)/scale;
  float zAcc = (analogRead(2) - zZero)/scale;
  
  pitch = (atan(xAcc/sqrt(pow(yAcc, 2) + pow(zAcc, 2))) * (180/PI));
  roll = (atan(yAcc/sqrt(pow(xAcc, 2) + pow(zAcc, 2))) * (180/PI));
  yaw = (acos(zAcc/sqrt(pow(xAcc, 2) + pow(yAcc, 2) + pow(zAcc, 2))) * (180/PI));
  
  float  val = (analogRead(3) + analogRead(4) + analogRead(5))/3;
/*  
  if(!calibrated && firstRead)
  {
    avgBend = val;
    firstRead = false;
  }
  else if(millis() < 1000)
    avgBend += (val + avgBend)/2;
  else
    {
      threshold = avgBend*0.8;
      calibrated = true;
    }
  */  
  
  
  String str = "";
  str+= val;



  if(pitch < 3 && pitch > -3 &&
     roll < 3 && roll > -3 &&
     yaw < 3 && yaw > -3)
   {
     str = "STILL";
   }
   else if(pitch < -5.5 && pitch > -8 &&
           roll < -1.5 && roll > - 5.5 &&
           yaw > 6.5)
   {
     str = "LEFT";
   }
    else if(pitch > 4 && pitch < 8 &&
           roll < -1 &&
           yaw > 5)
   {
     str = "RIGHT";
   }
   else if( pitch < 1.7 &&
            roll < -8 && roll > -12 &&
   yaw > 8 && yaw < 12)
{
  str = "UP";
}

if(val < 275)
{
  str = "DOWN";
 // Serial.println(avgBend);
}

  Serial.println(str);
}
