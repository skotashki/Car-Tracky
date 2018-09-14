
static unsigned long MR_trackMillis = 0;

void mil_reporter_loop()
{
  if (MR_trackMillis == 0)
  {
    MR_trackMillis = millis();
  }

  unsigned long currentMillis = millis();
  if (currentMillis - MR_trackMillis > 20000)
  {
    unsigned long currentTrackedDistanceCm = mil_tracker_current_distance_cm();
    mil_tracker_reset();

    if (currentTrackedDistanceCm > 0)
    {
      std_io_print_distance(currentTrackedDistanceCm);
      std_io_report_distance(currentTrackedDistanceCm);
    }
    
    MR_trackMillis = 0; 
  }
}
