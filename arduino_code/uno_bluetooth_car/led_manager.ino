#define PIN_SPEED_LED 10

void led_manager_setup()
{
  pinMode(PIN_SPEED_LED, OUTPUT);
}

void led_manager_speed_led(int state)
{
  digitalWrite(PIN_SPEED_LED, state);
}
