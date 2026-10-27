#include <SoftwareSerial.h>
SoftwareSerial mySerial(10, 11); // RX, TX

unsigned int sum0 = 0;
unsigned int sum1 = 0;
unsigned int sum2 = 0;
unsigned int sum3 = 0;

unsigned char counter = 0;
unsigned char Ncounter = 60;

int sensor1 = 100; // Value for the first sensor (1st quadrant)
int sensor2 = 150; // Value for the second sensor (2nd quadrant)
int sensor3 = 200; // Value for the third sensor (3rd quadrant)
int sensor4 = 250; // Value for the fourth sensor (4th quadrant)

// Variables for storing the coordinates of points in each quadrant
int x1, y1, x2, y2, x3, y3, x4, y4;

// Center of mass for diagonals
float centerX_diag1, centerY_diag1;
float centerX_diag2, centerY_diag2;

// Center of mass at the point where the diagonals intersect
float centerX, centerY;

// Arrays to store the last three centerX and centerY values for the median filter
float centerX_values[3] = {0, 0, 0};
float centerY_values[3] = {0, 0, 0};

// Index to store the last values
int filterIndex = 0;

// Function for sorting three elements and returning the median using a ternary operator
float medianFilter(float values[]) {
  float a = values[0];
  float b = values[1];
  float c = values[2];

  // Median filter using ternary operators
  return (a > b) ?
     	((b > c) ? b : (a > c ? c : a)) :
     	((a > c) ? a : (b > c ? c : b));
}
void setup() {
  Serial.begin(9600);
  mySerial.begin(9600);
}

void loop() {
  sum0 = sum0 + analogRead(0);
  sum1 = sum1 + analogRead(2);
  sum2 = sum2 + (analogRead(5)) / 2;
  sum3 = sum3 + analogRead(7);
  counter++;
 
  if (counter == Ncounter) {
	sensor1 = sum1 / Ncounter;
	sensor2 = sum0 / Ncounter;
	sensor3 = sum2 / Ncounter;
	sensor4 = sum3 / Ncounter;

// Define the coordinates for each quadrant:
	x1 = sensor1; y1 = sensor1;
	x2 = -sensor2; y2 = sensor2;
	x3 = -sensor3; y3 = -sensor3;
	x4 = sensor4; y4 = -sensor4;   

// Calculating the centres of mass for diagonals:
	centerX_diag1 = (x1 * sensor1 + x3 * sensor3) / (sensor1 + sensor3);
	centerY_diag1 = (y1 * sensor1 + y3 * sensor3) / (sensor1 + sensor3);
 
	centerX_diag2 = (x2 * sensor2 + x4 * sensor4) / (sensor2 + sensor4);
	centerY_diag2 = (y2 * sensor2 + y4 * sensor4) / (sensor2 + sensor4);

	centerX = abs((centerX_diag1 + centerX_diag2) / 2);
	centerY = abs((centerY_diag1 + centerY_diag2) / 2);

	centerX_values[filterIndex] = centerX;
	centerY_values[filterIndex] = centerY;

	// Update the index (ring buffer with 3 elements)
	filterIndex = (filterIndex + 1) % 3;

// Apply a median filter to centreX and centreY
	float filteredCenterX = medianFilter(centerX_values);
	float filteredCenterY = medianFilter(centerY_values);

	// Outputting filtered values to the serial port
	Serial.print(String(sensor2) + " ");
	Serial.print(String(sensor1) + " ");
	Serial.print(String(sensor3) + " ");
	Serial.print(String(sensor4) + " ");
	Serial.print(String(filteredCenterX) + " ");
	Serial.println(String(filteredCenterY));
	
mySerial.print(String(sensor2) + "|");
	mySerial.print(String(sensor1) + "|");
	mySerial.print(String(sensor3) + "|");
	mySerial.print(String(sensor4) + "|");
	mySerial.print(String(filteredCenterX) + "|");
	mySerial.println(String(filteredCenterY));    

	delay(100);

	// Resetting the counters for the next cycle
	counter = 0;
	sum0 = 0;
	sum1 = 0;
	sum2 = 0;
	sum3 = 0;
  }
}
