// thanks to: https://gist.github.com/Powder/3775852

import java.awt.Robot;
import java.awt.AWTException;
import processing.serial.*;
Serial myPort;

KeystrokeSimulator keySim;

int touch1;
int touch2;
int lastPress;

void setup() {
  println(Serial.list());
  keySim = new KeystrokeSimulator();
  myPort = new Serial(this, Serial.list()[0], 9600);
  myPort.bufferUntil('\n');
  size(10,10);
}

// not sure how to avoid this, but it can go in the background
void draw() {
  getData(myPort);
  float bg = (touch1 == 0)?100:200;
  background(bg);
}

void getData(Serial myPort) {
  String myString = myPort.readStringUntil('\n');
  if (myString != null) {
    myString = trim(myString);
    String items[] = split(myString, ',');
    if (items.length > 9) {
      touch1 = int(items[6]);
      touch2 = int(items[7]);
      if (touch1 == 0 && millis() - lastPress > 250) {
        try {
          keySim.keyRight();
          lastPress = millis();
        } catch (AWTException e) {
          println(e);
        }
      } else if (touch2 == 0 && millis() - lastPress > 250) {
        try {
          keySim.keyLeft();
          lastPress = millis();
        } catch (AWTException e) {
          println(e);
        }
      }
    }
  }
}

public class KeystrokeSimulator {
  private Robot robot;  
  KeystrokeSimulator(){
    try {
      robot = new Robot();  
    }
    catch(AWTException e){
      println(e);
    }
  }
  
  void keyLeft() throws AWTException {
      robot.keyPress(java.awt.event.KeyEvent.VK_LEFT);
  }
  void keyRight() throws AWTException {
      robot.keyPress(java.awt.event.KeyEvent.VK_RIGHT);
  }
  void simulate(char c) throws AWTException {
      robot.keyPress(c);
  }
}
