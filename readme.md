# Interactive Glove Applications

This repository contains different applications designed to work with a custom glove using a Lilypad Arduino, wired with conductive finger pads, the Lilypad accelerometer, flex sensors on the three middle fingers, and the Lilypad vibe board in the palm of the hand for haptic feedback. Step-by-step instructions for creating the glove can be found on [Instructables](http://www.instructables.com/id/Interactive-Gloves/).

Each application folder contains folders for the corresponding Arduino and Processing files. (Several of the Arduino files are the same (or very similar), but we put copies in each folder to avoid confusion.)

## Configuration

The pin configuration is defined in `GloveConfig.h`. For our glove, these pins were:

**Digital Pins**

| Name | Pin | Variable |
|---|---|---|
| Coin Motor (output) | 4 | `VIBE_PIN` |
| Index Finger Touchpad | 9 | `TOUCH_1` |
| Middle Finger Touchpad | 12 | `TOUCH_2` |
| Ring Finger Touchpad | 11 | `TOUCH_3` |
| Little Finger Touchpad | 10 | `TOUCH_4` |

**Analog Pins**

| Name | Pin | Variable |
|---|---|---|
| X Acceleration | 0 | `ACCEL_X` |
| Y Acceleration | 1 | `ACCEL_Y` |
| Z Acceleration | 2 | `ACCEL_Z` |
| Ring Finger Flex | 3 | `FLEX_3` |
| Middle Finger Flex | 4 | `FLEX_2` |
| Index Finger Flex | 5 | `FLEX_1` |

If your glove uses different pins, you will have to edit `GloveConfig.h` to the correct values.

**Note:** This file is included in each sketch to provide the pin numbers. In order to do this, the repository has symlinks in each sketch folder that point to the actual `GloveConfig.h` in the top level. If your OS does not allow symlinks (Windows), you will have to move the file into a subdirectory under `{Arduino folder}\hardware\libraries`, e.g., `hardware\libraries\MyCommon\GloveConfig.h`. Alternatively, you can [add it as a library](https://www.arduino.cc/en/hacking/libraries).


## Running / Development

Arduino code can be edited, compiled, and sent to an Arduino board using the [Arduino IDE](https://www.arduino.cc/en/Main/Software).

Processing code runs on the PC. Edit, build and run from the [Processing IDE](https://processing.org/download/?processing).


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

