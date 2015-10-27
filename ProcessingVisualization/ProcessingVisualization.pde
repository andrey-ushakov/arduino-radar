import processing.serial.*;

Serial arduinoPort;
String data;     // Data received from the serial port

void setup() {
  String portName    = Serial.list()[1]; // Change index to match your port
  arduinoPort        = new Serial(this, portName, 9600);
  
  
  size(500,500);
  background(255,255,255);
}


int index;
float angle;
float distance;

void draw() {
  if ( arduinoPort.available() > 0) {
    data = arduinoPort.readStringUntil('\n');
  }
  index    = data.indexOf(",");
  angle    = float(data.substring(0, index));
  distance = float(data.substring(index+1, data.length()-1));
  
  //println(distance);
}
