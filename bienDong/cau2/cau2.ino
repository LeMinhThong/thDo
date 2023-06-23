#include <math.h>

const int sensorPinA0 = A0;
const int sensorPinA1 = A1;
const float Vref = 4.9;
float sum = 0;

void setup() {
  Serial.begin(115200);
  analogReference(DEFAULT);
}

void loop() {
  for(int i = 0; i < 2000; i++) {
    int Xn = analogRead(sensorPinA0) - analogRead(sensorPinA1);
    float VthuCap = Xn * Vref / 1024.0;
    float IsoCap = VthuCap /10000 * 1000 * 1000; //mA
    sum += pow(IsoCap, 2);    
  }

  float Irms = sqrt(sum / 2000); //mA
  float P = Irms / 1000 * 220;

  Serial.print("Irms = ");
  Serial.print(Irms, 3); 
  Serial.println("(mA)");

  Serial.print("P = ");
  Serial.print(P, 3); 
  Serial.println("(W)");
  
}
