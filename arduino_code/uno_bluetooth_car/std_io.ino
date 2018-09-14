#include <SoftwareSerial.h>

#define PIN_SW_RX 8
#define PIN_SW_TX 9

SoftwareSerial swSerial(PIN_SW_RX, PIN_SW_TX); // RX, TX

void std_io_setup()
{
  Serial.begin(9600);
  swSerial.begin(115200);
}

int std_io_read_input()
{
  return Serial.read();
}

void std_io_print_distance(unsigned long distance)
{
  //Serial.print("Current Distance: ");
  //Serial.println(distance);
}

void std_io_report_distance(unsigned long distance)
{
  swSerial.println(distance);
}
