#include<math.h>
const int sensorPinA0 = A0;
const float Vref = 4.9;

const int RA = 18;
const int EA = 10;
const float y = 0.9;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  analogReference(DEFAULT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int sensorValue = analogRead(sensorPinA0);
  float Vo = sensorValue * Vref / 1024.0;
  float RB = (10 * Vo) / (5 - Vo);
  float EB = EA * (pow(10, (log10(RA/RB)/y)));
  Serial.print("EB = ");
  Serial.print(EB, 3);
  Serial.println("(lx)");
  delay(1000);
}
