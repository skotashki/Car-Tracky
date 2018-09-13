#include <WiFi.h>
#include <Web3.h>
#include <Contract.h>

#define USE_SERIAL Serial

#define ENV_SSID     "SoftuniHQ"
#define ENV_WIFI_KEY "Room4all"
#define MY_ADDRESS "0x70c9F6ABb74178fbD52c800F2D72Ab683F5F368B"
#define CONTRACT_ADDRESS "0x7914b79992225a6a42a2640594d62faa69f61043"
#define INFURA_HOST "ropsten.infura.io"
#define INFURA_PATH "/7a2a37996d564ccd86812bd19d4001de"

const char PRIVATE_KEY[] = {0xfd,0x47,0x09,0x81,0x6c,0x7a,0xb4,0xef,
                            0xf1,0xb5,0xb0,0x9b,0x3f,0x83,0x76,0x2a,
                            0xb9,0xda,0x5f,0x66,0x22,0x9c,0x91,0x7b,
                            0xea,0x98,0xa6,0xe9,0x8d,0x02,0xd3,0x53 };

const string host = INFURA_HOST;
const string path = INFURA_PATH;
const string myaddr = MY_ADDRESS;
const string contract_addr = CONTRACT_ADDRESS;

Web3 web3(&host, &path);

void eth_send_example();

void setup() {
    USE_SERIAL.begin(115200);

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

    eth_send_example();
}

void loop() {
    // put your main code here, to run repeatedly:
}

void eth_send_example() {
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
    string p = contract.SetupContractData(&func, 123);
    string result = contract.SendTransaction(nonceVal, gasPriceVal, gasLimitVal, &toStr, &valueStr, &p);

    USE_SERIAL.println(result.c_str());
}
