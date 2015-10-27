import processing.serial.*;

int max_distance = 40; // Maximum distance we want to ping for (in centimeters)
float coefCmPx;

Serial arduinoPort;
String data;     // Data received from the serial port

int w = 700;
int h = 350;
int index;           // buffer variable
float angle    = 0;  // radar angle from Arduino
float distance = 0;  // distance in cm to object from Arduino
float distancePx = 0;

void setup() {
  String portName    = Serial.list()[1]; // Change index to match your port
  arduinoPort        = new Serial(this, portName, 9600);
  arduinoPort.bufferUntil('\n');
  
  coefCmPx = h / max_distance;
  
  size(w, h);
  smooth();
}


// Draw radar skeleton
void drawRadar() {
  pushMatrix();
  translate(w/2, h); // moves the starting coordinats to new location
  noFill();
  strokeWeight(1);
  stroke(98, 245, 31);    // green
  // draws the arc lines
  arc(0, 0, 2*h-40, 2*h-40, PI, TWO_PI);
  arc(0, 0, 3*h/2-15, 3*h/2-15, PI, TWO_PI);
  arc(0, 0, h-15, h-15, PI, TWO_PI);
  arc(0, 0, h/2-15, h/2-15, PI, TWO_PI);
  // draws the angle lines
  
  line(0, 0, -w*cos(radians(30)), -w*sin(radians(30)));
  line(0, 0, -w*cos(radians(60)), -w*sin(radians(60)));
  line(0, 0, -w*cos(radians(90)), -w*sin(radians(90)));
  line(0, 0, -w*cos(radians(120)), -w*sin(radians(120)));
  line(0, 0, -w*cos(radians(150)), -w*sin(radians(150)));
  popMatrix();
}

// Draw moving green radar line
void drawLine() {
  pushMatrix();
  strokeWeight(2);
  stroke(30, 250, 60);  // green lines
  translate(w/2, h);
  line(0, 0, (w/2-10)*cos(radians(angle)), -(w/2-10)*sin(radians(angle))); // draws the line according to the angle
  popMatrix();
}

// Draw obstacles
void drawLineObstacle() {
  pushMatrix();
  translate(w/2, h);
  strokeWeight(2);
  stroke(255,10,10); // red

  if(distance < max_distance && distance != 0) {
    distancePx = coefCmPx * distance;
    line(distancePx*cos(radians(angle)),
          -distancePx*sin(radians(angle)),
          (w/2-10)*cos(radians(angle)),
          -(w/2-10)*sin(radians(angle)));
  }
  popMatrix();
}

void draw() {
  // fade of moving line
  noStroke();
  fill(0, 1); 
  rect(0, 0, w, h);
  
  drawRadar();
  drawLine();
  drawLineObstacle();
}


void serialEvent (Serial myPort) {
  data = myPort.readStringUntil('\n');
  if(data != null) {
    index    = data.indexOf(",");
    angle    = float(data.substring(0, index));
    distance = float(data.substring(index+1, data.length()-1));
  }
  println(distance);
}
