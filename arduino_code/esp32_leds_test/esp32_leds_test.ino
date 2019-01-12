#define ESP32

#include <OBD2UART.h>

#define LED_OBD_INIT 18
#define LED_OBD_CONNECTED 16
#define LED_OBD_CONNECTING 2
#define LED_OBD_ERROR 4
#define LED_OBD_READING 22

COBD obd;

void setup() {
  Serial.begin(115200);
  pinMode(LED_OBD_INIT, OUTPUT);
  pinMode(LED_OBD_CONNECTED, OUTPUT);
  pinMode(LED_OBD_CONNECTING, OUTPUT);
  pinMode(LED_OBD_ERROR, OUTPUT);
  pinMode(LED_OBD_READING, OUTPUT);
  
  digitalWrite(LED_OBD_INIT, LOW);
  digitalWrite(LED_OBD_CONNECTED, LOW);
  digitalWrite(LED_OBD_CONNECTING, LOW);
  digitalWrite(LED_OBD_ERROR, LOW);
  digitalWrite(LED_OBD_READING, LOW);
}

void loop() {
  delay(500);
  digitalWrite(LED_OBD_CONNECTING, HIGH);
  digitalWrite(LED_OBD_CONNECTED, HIGH);
  digitalWrite(LED_OBD_ERROR, HIGH);
  digitalWrite(LED_OBD_INIT, HIGH);
  digitalWrite(LED_OBD_READING, HIGH);
  delay(500);
}
