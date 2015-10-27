import processing.serial.*;

Serial arduinoPort;
String data;     // Data received from the serial port

int w = 500;
int h = 500;

void setup() {
  String portName    = Serial.list()[1]; // Change index to match your port
  arduinoPort        = new Serial(this, portName, 9600);
  arduinoPort.bufferUntil('\n');
  
  size(w, h);
  background(255,255,255);
  ellipse(w/2, h/2, w, h);
}


int index;
float angle;
float distance;

void draw() {
  if ( arduinoPort.available() > 0) {
    
  }
  
  
}


void serialEvent (Serial myPort) {
  data = myPort.readStringUntil('\n');
  println(data);
  if(data != null) {
    index    = data.indexOf(",");
    angle    = float(data.substring(0, index));
    distance = float(data.substring(index+1, data.length()-1));
  }
}
