#define PIN_12 12

void led_manager_setup()
{
  pinMode(PIN_12, OUTPUT);
}

void led_manager_speed_led(int state)
{
  digitalWrite(PIN_12, state);
}
