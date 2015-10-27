import processing.serial.*;

Serial arduinoPort;
String data;     // Data received from the serial port

void setup() {
  String portName    = Serial.list()[1]; // Change index to match your port
  arduinoPort        = new Serial(this, portName, 9600);
  println(portName);
}

void draw() {
  if ( arduinoPort.available() > 0) {
    data = arduinoPort.readStringUntil('\n');
    println("ok");
  }
  println(data);
}
