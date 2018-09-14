#include <WiFi.h>
#include <Web3.h>
#include <Contract.h>


#define SERIAL_BUFFER_SIZE 100
#define USE_SERIAL Serial

#define ENV_SSID     "Xperia Z3+_74db"
#define ENV_WIFI_KEY "12345678"
#define GANACHE_HOST "35.242.225.96"
#define MY_ADDRESS "0x4b6a4d63684bca7582473d8d7dc7fb25d24a6442"
#define CONTRACT_ADDRESS "0x1e4743ffd49942cf804050bd48d92c8875722d40"

const char PRIVATE_KEY[] = {0x17, 0xdd, 0x56, 0x66, 0xdc, 0x2f, 0x77, 0xf3,
                            0x97, 0xfb, 0xda, 0x1c, 0x39, 0xd5, 0xe1, 0x91,
                            0x46, 0x88, 0x3d, 0x0a, 0xda, 0x22, 0x52, 0x3b,
                            0x47, 0xeb, 0x6b, 0xe1, 0x52, 0xc5, 0xea, 0x3d};

const string host = GANACHE_HOST;
const string path = "/";
const string myaddr = MY_ADDRESS;
const string contract_addr = CONTRACT_ADDRESS;

long accumulated_mileage = 0;

Web3 web3(&host, &path);
unsigned long trackMillis = 0;
unsigned long wifiLedTrackMillis = 0;

void setup() {
    USE_SERIAL.begin(115200);
    pinMode(32, OUTPUT);
    pinMode(25, OUTPUT);
    
    digitalWrite(25, LOW);
    digitalWrite(32, LOW);

    for(uint8_t t = 4; t > 0; t--) {
        USE_SERIAL.printf("[SETUP] WAIT %d...\n", t);
        USE_SERIAL.flush();
        delay(1000);
    }

    WiFi.begin(ENV_SSID, ENV_WIFI_KEY);  

    
    // attempt to connect to Wifi network:
    while (WiFi.status() != WL_CONNECTED) {
        Serial.print(".");
        // wait 1 second for re-trying
        delay(1000);
    }

    USE_SERIAL.println("Connected");

    digitalWrite(25, HIGH);

//    eth_send_example(15);
}

void loop() {
  if (wifiLedTrackMillis == 0)
  {
    wifiLedTrackMillis = millis();
  }

  unsigned long currentMillis = millis();
  if (wifiLedTrackMillis != 0 && currentMillis - wifiLedTrackMillis > 5000)
  {
    digitalWrite(25, LOW);
  }
  
  if (trackMillis != 0 && (currentMillis - trackMillis) > 5000)
  {
    digitalWrite(32, LOW);
    trackMillis = 0;
  }
  
  // put your main code here, to run repeatedly:
  if (Serial.available() > 0)
  {
    char buffer[SERIAL_BUFFER_SIZE];
    memset(buffer, 0, SERIAL_BUFFER_SIZE);
    Serial.readBytesUntil( '\0', buffer, SERIAL_BUFFER_SIZE);
    Serial.println(buffer);
    eth_send_example(strtol(buffer, NULL, 10));
    // if(accumulated_mileage == 0) {
    //     eth_send_example(strtol(buffer, NULL, 10));
    // } else {
    //     accumulated_mileage += strtol(buffer, NULL, 10);
    //     long mileage_to_send = accumulated_mileage;
    //     accumulated_mileage = 0;
    //     eth_send_example(mileage_to_send);
    // }
  }
}

void eth_send_example(long currentMileage) {
    Contract contract(&web3, &contract_addr);
    contract.SetPrivateKey((uint8_t*)PRIVATE_KEY);
    uint32_t nonceVal = (uint32_t)web3.EthGetTransactionCount(&myaddr);
    uint32_t gasPriceVal = 1410065400000;
    uint32_t  gasLimitVal = 3000000;
    string toStr = CONTRACT_ADDRESS;
    string valueStr = "0x00";
    uint8_t dataStr[100];
    memset(dataStr, 0, 100);
    string func = "addMileage(uint256)";
    string p = contract.SetupContractData(&func, currentMileage);
    USE_SERIAL.println(p.c_str());
    string result = contract.SendTransaction(nonceVal, gasPriceVal, gasLimitVal, &toStr, &valueStr, &p);
    USE_SERIAL.println(result.c_str());
    
    digitalWrite(32, HIGH);
    trackMillis = millis();

//    if(strstr(result, "error") != NULL) {
//        accumulated_mileage += currentMileage;
//    }
}
