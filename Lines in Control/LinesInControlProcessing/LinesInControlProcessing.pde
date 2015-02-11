import processing.serial.*;
Serial myPort;

float pitch, roll, yaw;

// glove inputs
float xAcc, yAcc, zAcc;
int touch1, touch2, touch3, touch4;
float flex1, flex2, flex3;

float xZero = 508; // range like 450-600??
float yZero = 557;
float zZero = 519;
float scale = 556; // z value at rest i.e. gravity

float flex1Zero = 325;
float flex2Zero = 298;
float flex3Zero = 334;
float flex1Min = 220;
float flex2Min = 110;
float flex3Min = 230;

int length = 10;

int n = 20;
Cell[][] lines = new Cell[n][n];

void setup()
{
  size(500, 500, P2D);
  //stroke(0, 0, 0, 20);

  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');

  int len = (width - 50)/n;

  for(int i = 0; i < n; i++)
  {
    for(int j = 0; j < n; j++)
    {
      lines[i][j] = new Cell(37+len*i, 37+len*j);      
    }
  }

}

void draw()
{
  background(255);
    
  for(int i = 0; i < n; i++)
  {
    for(int j = 0; j < n; j++)
    {
      lines[i][j].Sense();
    }
  }
}

class Cell
{
  int X, Y;
  float Angle;
  color Color;
  
  Cell(int x, int y)
  {
    this.X = x;
    this.Y = y;
    this.Color = color(50, 50, 100);
    
    Angle = atan((float)(y-(height/2)) / (float)(x-(width/2)));
  }
  
  void Sense()
  {
    stroke(this.Color);
    strokeWeight(1);
    
    float distanceCoef = 0.04*sqrt(pow(abs(this.X - width/2), 2) + pow(abs(this.Y - height/2), 2))/sqrt(pow(width/2, 2) + pow(height/2, 2));
    
    line(this.X, this.Y, this.X + cos(this.Angle + pitch*distanceCoef)*length/2, this.Y + sin(this.Angle + pitch*distanceCoef)*length/2);
    line(this.X, this.Y, this.X - cos(this.Angle + pitch*distanceCoef)*length/2, this.Y - sin(this.Angle + pitch*distanceCoef)*length/2);
  }
}

void calcAngles() 
{
  pitch = (atan(xAcc/sqrt(pow(yAcc, 2) + pow(zAcc, 2))) * (180/PI));
  roll = (atan(yAcc/sqrt(pow(xAcc, 2) + pow(zAcc, 2))) * (180/PI));
  yaw = (acos(zAcc/sqrt(pow(xAcc, 2) + pow(yAcc, 2) + pow(zAcc, 2))) * (180/PI)); 
}

void updateSensorValues()
{
  flex1 = map(flex1, flex1Min, flex1Zero, 0, 10);
  flex2 = map(flex2, flex2Min, flex2Zero, 0, 10);
  flex3 = map(flex3, flex3Min, flex3Zero, 0, 10);

  length = (int)(2.5 + ((flex1+flex2+flex3)/3));  
}

void serialEvent(Serial myPort) 
{
  String myString = myPort.readStringUntil('\n');

  if (myString != null)
  {
    myString = trim(myString);
    String items[] = split(myString, ',');
    
      if (items.length > 9)
      {
        xAcc = float(items[0]);
        yAcc = float(items[1]);
        zAcc = float(items[2]);
        
        flex1 = float(items[3]);
        flex2 = float(items[4]);
        flex3 = float(items[5]);
        
        touch1 = int(items[6]);
        touch2 = int(items[7]);
        touch3 = int(items[8]);
        touch4 = int(items[9]);
      }
    
    // normalize to g's
    xAcc = (xAcc - xZero)/scale;
    yAcc = (yAcc - yZero)/scale;
    zAcc = (zAcc - zZero)/scale;
    
    calcAngles();
    updateSensorValues();
  }
}

