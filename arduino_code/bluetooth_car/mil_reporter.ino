
static unsigned long MR_trackMillis = 0;
static unsigned int speedLedState = 0;

void mil_reporter_loop()
{
  if (MR_trackMillis == 0)
  {
    MR_trackMillis = millis();
  }

  unsigned long currentMillis = millis();
  if (currentMillis - MR_trackMillis > 5000)
  {
    led_manager_speed_led(LOW);
  }
  
  if (currentMillis - MR_trackMillis > 20000)
  {
    unsigned long currentTrackedDistanceCm = mil_tracker_current_distance_cm();
    mil_tracker_reset();

    if (currentTrackedDistanceCm > 0)
    {
      led_manager_speed_led(HIGH);
      std_io_print_distance(currentTrackedDistanceCm);
      std_io_report_distance(currentTrackedDistanceCm);
    }
    
    MR_trackMillis = 0; 
  }
}
