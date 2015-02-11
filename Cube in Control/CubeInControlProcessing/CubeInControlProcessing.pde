// Heavily adapted from http://physics.rutgers.edu/~aatish/teach/srr/workshop3.pdf

import processing.serial.*;
Serial myPort;

// cube parameters
float position;
float pitch, roll, yaw;

// glove inputs
float xAcc, yAcc, zAcc;
int touch1, touch2, touch3, touch4;
float flex1, flex2, flex3;

// scale factors, numbers determined experimentally

// orientation math
// zeroes should be the minimum accel value
// ie, x and y when board is lying flat, z when straight up
float xZero = 508; // range like 450-600??
float yZero = 557;
float zZero = 519;
float scale = 556; // z value at rest i.e. gravity

// for box size
float flex1Zero = 325;
float flex2Zero = 298;
float flex3Zero = 334;
float flex1Min = 220;
float flex2Min = 110;
float flex3Min = 230;

void setup() {
  // square window, center the box
  size(450, 450, P3D);
  position = width/2;
  
  println(Serial.list());
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  
  // enable smoothing for 3D:
  //hint(ENABLE_OPENGL_4X_SMOOTH); // does not work on my system?
}

void draw () {
  getData(myPort);
  float bg = (touch4 == 0)?100:200;
  background(bg);
  drawBox();
}

void calcAngles() {
  pitch = (atan(xAcc/sqrt(pow(yAcc, 2) + pow(zAcc, 2))) * (180/PI));
  roll = (atan(yAcc/sqrt(pow(xAcc, 2) + pow(zAcc, 2))) * (180/PI));
  yaw = (acos(zAcc/sqrt(pow(xAcc, 2) + pow(yAcc, 2) + pow(zAcc, 2))) * (180/PI)); 
}

void drawBox() {
  // translate from origin to center:
  translate(position, position, position);
  rotateX(radians(roll));
  rotateY(radians(pitch));
  rotateZ(radians(yaw));
  
  // Color is determined by touch pads
  float r = (touch1 == 0)?255:50;
  float g = (touch2 == 0)?255:50;
  float b = (touch3 == 0)?255:50;
  float br = (touch4 == 0)?2:1;
  fill(r/br,g/br,b/br);
  
  // Size is determined by flex
  float w = map(flex1, flex1Min, flex1Zero, 25,75); 
  float h = map(flex2, flex2Min, flex2Zero, 25,75); 
  float d = map(flex3, flex3Min, flex3Zero, 25,75); 
  box(w,h,d);
}

void getData(Serial myPort) {
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    myString = trim(myString);
    String items[] = split(myString, ',');
    if (items.length > 9) {
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
  }
}
