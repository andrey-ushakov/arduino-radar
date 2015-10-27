#include <NewPing.h>
#include <Servo.h> 

#define TRIGGER_PIN  12  // Arduino pin tied to trigger pin on the ultrasonic sensor.
#define ECHO_PIN     11  // Arduino pin tied to echo pin on the ultrasonic sensor.
#define MAX_DISTANCE 200 // Maximum distance we want to ping for (in centimeters). Maximum sensor distance is rated at 400-500cm.

Servo myservo;

int dist;
int servoRotation = 1;
int rotationStep = 1;

// NewPing setup of pins and maximum distance.
NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);

void print(int rot, int dist) {
  Serial.print(rot);
  Serial.print(",");
  Serial.println(dist);
}

void setup() {
  Serial.begin(9600);
  myservo.attach(9);
  myservo.write(servoRotation);
}

void loop() {
  // get distance
  dist = sonar.ping_cm();
  
  // turn servo
  myservo.write(servoRotation);
  if(servoRotation >= 180) {
    rotationStep *= -1;
  } else if(servoRotation <= 0) {
    rotationStep *= -1;
  }
  
  // print info
  print(servoRotation, dist);
  
  servoRotation += rotationStep;
  delay(100);
}
