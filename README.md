# 2D-Mapping-Bot

## Aim

To create a bot which maps a 2D top view of the floor, plotting all the obstacles and boundaries of the area.

---

## Components List

- Arduino IDE
- HC05 Bluetooth Module
- 28-BYJ-48 Stepper Motor (2)
- ULN2003 Stepper Driver (2)
- SG90 Micro Servo
- HCSR04 Ultrasonic Sensor
- 9V Battery
- 6V Battery
- Breadboard (small)
- Switch
- Jumper Wires
- Zip Ties
- Chassis (Metal Body, Wheels)

---

## Working
The 2D mapping bot has been designed and programmed to be controlled by the user in terms of locomotion. The working can be classified into two major processes: Locomotion and Scanning.

### Locomotion
The HC05 Bluetooth module is utilised for communication purpose to move the bot throughout the workspace. The stepper motors used are the 28-BYJ-48 model which are to be used along with the ULN2003 stepper driver for each. The stepper motors are utilised to ensure fixed movement of the bot, i.e. a fixed distance each time a command is passed to it, to ensure a proper scaled plotting of the workspace. Locomotion is controlled by connecting the module to the PC and clicking the arrow keys on the keyboard after opening the Processing IDE.

### Scanning
Scanning is done by the HCSR04 ultrasonic sensor mounted upon an SG90 servo motor which rotates from 0 to 180 degrees back and forth. Scanning is done by sending pulses of ultrasonic waves for each angular position of the sensor. Scanning goes on continuously as long as the bot is switched on. It comes to a halt only when the bot receives a command to perform a particular locomotive action. As soon as that action is completed, scanning resumes.

---

## Results

(Click on the Image below to see the video)

[![Alt text](https://img.youtube.com/vi/xwrsreReJ0o/0.jpg)](https://www.youtube.com/watch?v=xwrsreReJ0o)

## Credits

This project was done by me and [Amogh Juloori](https://github.com/AmoghJuloori)
