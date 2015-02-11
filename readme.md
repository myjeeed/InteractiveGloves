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

Each application folder contains folders for the corresponding Arduino and Processing files.

## Cube In Control

This demonstrates all the different sensors on the glove. A 3D cube rotates with accelerometer readings, shrinks when you flex your fingers, and changes color (R, G, B, and brightness) according on finger touches.  The little finger, in addition to controlling brightness, also turns on the motor.

## Pacman Gloves

The accelerometer and flex sensors are used detect orientation of the hand, which is used to control a game of pacman.
