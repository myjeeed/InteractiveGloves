# Interactive Glove Applications

This repository contains different applications designed to work with a custom glove using a Lilypad Arduino, wired with conductive finger pads, the Lilypad accelerometer, flex sensors on the three middle fingers, and the Lilypad  vibe board in the palm of the hand for haptic feedback.

The pins are as follows:

**Digital Pins:**  
4 - Coin Motor (output)  
9 - Index finger  
12 - Middle finger touch  
11 - Ring finger touch  
10 - Little finger touch

**Analog Pins:**  
0 - X acceleration  
1 - Y acceleration  
2 - Z acceleration  
3 - Ring finger flex  
4 - Middle finger flex  
5 - Index finger flex

Each application folder contains folders for the corresponding Arduino and Processing files.  (Several of the Arduino files are the same (or very similar), but we put copies in each folder to avoid confusion.)

## Asteroids

The base game is borrowed from [this sketch by Mark Gillespie](http://www.openprocessing.org/sketch/106239). Instead of the original WASD/space controls, the motion is now controlled by the accelerometer, and laser fire and mouse clicks by the touch pads. The ship speed also varies with the flex sensor readings, and a small vibration occurs when you crash.

## Cube In Control

This demonstrates all the different sensors on the glove. A 3D cube rotates with accelerometer readings, shrinks when you flex your fingers, and changes color (R, G, B, and brightness) according on finger touches.  The little finger, in addition to controlling brightness, also turns on the motor.

## Lines In Control

A music visualizer, with colors and line field controlled by hand orientation and flex.

## Pacman Gloves

The accelerometer and flex sensors are used detect orientation of the hand, which is used to control a game of pacman.  The original pacman game code is from [this sketch by Laurel Deel](http://www.openprocessing.org/sketch/46944).

## Presenter

The Processing file here makes use of Java's Robot class (thanks to [this gist](https://gist.github.com/Powder/3775852) for inspiration!) to send keystrokes to a program.  In this case, we use the first two fingers to send right/left signals, suitable for something like a Powerpoint presentation.
