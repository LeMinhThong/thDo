const int sensorPinA0 = A0;
const int sensorPinA1 = A1;
const float Vref = 4.9;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  analogReference(DEFAULT);
}

void loop() {
  // put your main code here, to run repeatedly:
  int Xn = analogRead(sensorPinA0) - analogRead(sensorPinA1);
  float VthuCap = Xn * Vref / 1024.0;
  float IthuCap = VthuCap / 10000; //A
  float IsoCap = IthuCap * 1000; //A
  IsoCap = IsoCap * 1000; //mA 

  Serial.println(IsoCap, 3);
}
