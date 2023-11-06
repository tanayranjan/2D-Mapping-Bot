#include<Servo.h>
#include <Stepper.h>
#define STEPS 2038 // the number of steps in one revolution of your motor (28BYJ-48)

Stepper stepperR(STEPS, 8, 10, 9, 11);
Stepper stepperL(STEPS, 4, 6, 5, 7);
Servo Myservo;
int i=1;
int n;
int pos=0,k=0;
volatile char inputByte;
unsigned long pingTravelTime;
int trigPin=12;
int echoPin=13;

void setup() {
 Serial.begin(9600);
 Myservo.attach(3);
 pinMode(2,OUTPUT);
 pinMode(trigPin,OUTPUT);
 pinMode(echoPin,INPUT);
 pinMode(4,OUTPUT);
 pinMode(5,OUTPUT);
 pinMode(6,OUTPUT);
 pinMode(7,OUTPUT);
 pinMode(8,OUTPUT);
 pinMode(9,OUTPUT);
 pinMode(10,OUTPUT);
 pinMode(11,OUTPUT);

 digitalWrite(interruptPin,HIGH);
}

void loop() {
 Myservo.write(pos);
 delay(10);
 digitalWrite(trigPin,LOW);
 delayMicroseconds(10);
 digitalWrite(trigPin,HIGH);
 delayMicroseconds(10);
 digitalWrite(trigPin,LOW);
 pingTravelTime=pulseIn(echoPin,HIGH);
 if(Serial.available()>0) {
   inputByte= Serial.read();
   digitalWrite(interruptPin,LOW);
   command();
   digitalWrite(4,LOW);
   digitalWrite(5,LOW);
   digitalWrite(6,LOW);
   digitalWrite(7,LOW);
   digitalWrite(8,LOW);
   digitalWrite(9,LOW);
   digitalWrite(10,LOW);
   digitalWrite(11,LOW);
 }
 else {
   digitalWrite(interruptPin,HIGH);
 }
 Serial.print(pos);
 Serial.print(',');
 Serial.print(pingTravelTime);
 Serial.print('.');
 if (pos==180)
 i=-1;
 if (pos==0)
 i=1;
 pos =pos+i;
}
void command() {
 if(inputByte=='F') {
     for(n=0;n<=1024;n++) {
     stepperR.setSpeed(10);
     stepperR.step(2);
     stepperL.setSpeed(10);
     stepperL.step(2);
     }

 }
 if(inputByte=='R') {
   for(n=0;n<=1200;n++) {
   stepperL.setSpeed(10);
   stepperL.step(1);
   stepperR.setSpeed(10);
   stepperR.step(-1);
   }
 }
 if(inputByte=='L') {
   for(n=0;n<=1200;n++) {
   stepperL.setSpeed(10);
   stepperL.step(-1);
   stepperR.setSpeed(10);
   stepperR.step(1);
   }
 }
 if(inputByte=='B') {
     for(n=0;n<=1024;n++) {
     stepperR.setSpeed(10);
     stepperR.step(-2);
     stepperL.setSpeed(10);
     stepperL.step(-2);
     }
 }
}
