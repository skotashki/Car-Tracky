#define ESP32

#include <OBD2UART.h>

#define LED_OBD_INIT 18
#define LED_OBD_CONNECTED 15
#define LED_OBD_CONNECTING 2
#define LED_OBD_ERROR 4
#define LED_OBD_READING 22

COBD obd;

void setConnectionLed() {
  OBD_STATES currentState = obd.getState();

  int connectingLed = false;
  int connectedLed = false;
  int errorLed = false;
  if (currentState == OBD_CONNECTING) {
    connectingLed = true;
  } else if (currentState == OBD_CONNECTED) {
    connectedLed = true;
  }else if (currentState == OBD_FAILED) {
    errorLed = true;
  }

  digitalWrite(LED_OBD_CONNECTING, connectingLed);
  digitalWrite(LED_OBD_CONNECTED, connectedLed);
  digitalWrite(LED_OBD_ERROR, errorLed);
  digitalWrite(LED_OBD_READING, LOW);
}

void turnOffLeds() {
  digitalWrite(LED_OBD_CONNECTING, LOW);
  digitalWrite(LED_OBD_CONNECTED, LOW);
  digitalWrite(LED_OBD_ERROR, LOW);
  digitalWrite(LED_OBD_READING, LOW);
}

void reconnect()
{
  digitalWrite(LED_OBD_INIT, LOW);
  //obd.uninit();
  while (!obd.init()) {
    delay(500);
    turnOffLeds();
    delay(500);
    setConnectionLed();
    delay(2000);
  }
  digitalWrite(LED_OBD_INIT, HIGH);
}

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

  delay(500);
  obd.begin();
  digitalWrite(LED_OBD_INIT, LOW);
  while (!obd.init());
  digitalWrite(LED_OBD_INIT, HIGH);
  
  reconnect();
}

void loop() {
  static byte pids[]= {PID_SPEED};
  static byte index = 0;
  static byte pids_size = sizeof(pids);
  static unsigned long long stopwatch = millis();
  byte pid = pids[index];
  
  int value;
//  if (obd.readPID(PID_RPM, value)) {
//    if (value > 1200) {
//      digitalWrite(LED_OBD_READING, HIGH);
//    } else {
//      digitalWrite(LED_OBD_READING, LOW);
//    }
//  }

  unsigned long long currentTime = millis();
  int res = stopwatch - currentTime;
  Serial.print("SW: ");
  Serial.print(res);
  Serial.print("\n");
  stopwatch = currentTime;
  
  if (obd.readPID(pid, value)) {
    Serial.print("PID ");
    if (pid == PID_ODOMETER) {
      Serial.print("ODO");
    } else if (pid == PID_RPM) {
      Serial.print("RPM");
    } else if (pid == PID_SPEED) {
      Serial.print("SPD");
    } else if (pid == PID_DISTANCE) {
      Serial.print("DIST");
    }
    Serial.print(": ");

    Serial.print(value);
    Serial.print("\n");
  } 
  
  index = (index + 1) % pids_size;
  delay(200);
    
//  delay(500);
//  digitalWrite(LED_OBD_CONNECTING, HIGH);
//  digitalWrite(LED_OBD_CONNECTED, HIGH);
//  digitalWrite(LED_OBD_ERROR, HIGH);
//  digitalWrite(LED_OBD_INIT, HIGH);
//  delay(500);
}
