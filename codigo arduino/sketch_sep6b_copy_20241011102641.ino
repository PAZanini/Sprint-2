const int PINO_SENSOR_UMIDADE_SOLO = A0;

void setup() {
  Serial.begin(9600);
  pinMode(PINO_SENSOR_UMIDADE_SOLO, INPUT);
}

void loop() {
  int leituraSensor = analogRead(PINO_SENSOR_UMIDADE_SOLO);
  float porcentagemUmidade = (leituraSensor / 1023.0) * 100;
  Serial.println(porcentagemUmidade);
  delay(1000);
}
