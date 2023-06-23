const int sensorPinA0 = A0;
const float Vref = 4.9;

const int T1 = -10;
const int T2 = 120;

const int V1 = 1648;
const int V2 = 565;

void setup()
{
  Serial.begin(9600);
  analogReference(DEFAULT);
}

void loop()
{
  int sensorValue = analogRead(sensorPinA0);
  float Vtemp = sensorValue * Vref / 1024.0;
  float T = (((Vtemp * 1000 - V1) * (T2 - T1)) / (V2 - V1))+T1;

  Serial.print("T = ");
  Serial.print(T, 3);
  Serial.println(" (*C)");
  delay(1000);
}
