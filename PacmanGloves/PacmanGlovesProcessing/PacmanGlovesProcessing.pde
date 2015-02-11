import processing.serial.*; // import the serial lib
Serial myPort; // the serial port
/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/46944*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */
Pacman pacman;
PImage blankMap;
PImage pacMan;

//pX = pacman.get(x);

void setup(){
  size(640,480);
  smooth();
  pacMan = loadImage("pacman_LEFT_open.png");
  pacman = new Pacman(318,254);
  blankMap = loadImage("pacman_blankmap.png");
  imageMode(CENTER);
  //frameRate(8);
  
  println(Serial.list());
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);
  // only generate a serial event when you get a newline:
  myPort.bufferUntil('\n');
  
}

  int status = 0; //still {1: up   2: right   3: down    4: left}

void draw()
{
  image(blankMap,width/2,height/2);
  image(pacMan,318,254);
  //pacman.display();
  pacman.ColMap();
  pacman.update();
  if(status == 4){
      image(blankMap,width/2,height/2);
       pacman.displayL();
     }
  if(status == 2){
      image(blankMap,width/2,height/2);
       pacman.displayR();
     }
  if(status == 1){
      image(blankMap,width/2,height/2);
       pacman.displayU();
     }
  if(status == 3){
      image(blankMap,width/2,height/2);
       pacman.displayD();
     }

}

void serialEvent(Serial myPort) {
  // read the serial buffer:
  String myString = myPort.readStringUntil('\n');
  // if you got any bytes other than the linefeed:
  if (myString != null) {
    myString = trim(myString);
    // split the string at the commas
    println(myString);
    if(myString.equals("STILL"))
      {
      }
    else if(myString.equals("UP"))
      status = 1;
    else if(myString.equals("RIGHT"))
      status = 2;
    else if(myString.equals("DOWN"))
      status = 3;
    else if(myString.equals("LEFT"))
      status = 4;
    
     //still {1: up   2: right   3: down    4: left}
     
     
  }
  
}
