const int sensorPinA0 = A0;
const float Vref = 4.9;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  analogReference(DEFAULT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int sensorValue = analogRead(sensorPinA0);
  float VE = sensorValue * Vref / 1024.0;
  float Ipce = VE / 10000; //A
  Ipce = Ipce * 1000000.0; //uA
  float E = Ipce * 4 / 3;

  Serial.print("E: ");
  Serial.print(E, 3);
  Serial.println(" (lx)");
  delay(1000);
}
