#define __ASSERT_USE_STDERR
#include <assert.h>

#define SPEED_CM_S ((long)15)
#define MILLIS_IN_S ((long)1000)
#define REPORTING_PERIOD_S ((long)5)
#define REPORTING_PERIOD_MS (MILLIS_IN_S * REPORTING_PERIOD_S)

#define REPORTING_PERIOD_S_SPEED (SPEED_CM_S * REPORTING_PERIOD_S)

static unsigned long trackMillis = 0;
static unsigned long currentDistanceCm = 0;

void mil_tracker_reset()
{
  currentDistanceCm = 0;
}

unsigned long mil_tracker_current_distance_cm()
{
  return currentDistanceCm;
}

void mil_tracker_loop(int isMoving)
{
  if (isMoving)
  {
    if (!mil_tracker_is_recording())
    {
      mil_tracker_start_recording();
    }

    if (mil_tracker_has_reporting_period_passed())
    {
      mil_tracker_increment_current_distance();
      mil_tracker_start_recording();

      Serial.print("Tracked speed while moving: ");
      Serial.println(currentDistanceCm);
    }
  }
  else
  {
    if (mil_tracker_is_recording())
    {
      mil_tracker_increment_current_distance();
      
      Serial.print("Tracked speed after stopping movement: ");
      Serial.println(currentDistanceCm);
    }

    mil_tracker_stop_recording();
  }
}

static bool mil_tracker_is_recording()
{
  return trackMillis != 0;
}

static void mil_tracker_start_recording()
{
  trackMillis = millis();
}

static int mil_tracker_has_reporting_period_passed()
{
  return mil_tracker_current_tracked_millis() > REPORTING_PERIOD_MS;
}

static unsigned long mil_tracker_current_tracked_millis()
{
  unsigned long currentMillis = millis();
  //assert(currentMillis > trackMillis);
  
  return currentMillis - trackMillis;
}

static void mil_tracker_increment_current_distance()
{
//  Serial.print("Current tracked millis: ");
//  Serial.println(mil_tracker_current_tracked_millis());
//  Serial.print("REPORTING_PERIOD_MS: ");
//  Serial.println((long)REPORTING_PERIOD_MS);
//  Serial.print("REPORTING_PERIOD_S_SPEED: ");
//  Serial.println(REPORTING_PERIOD_S_SPEED);
  currentDistanceCm += (((float)mil_tracker_current_tracked_millis()) / REPORTING_PERIOD_MS) * REPORTING_PERIOD_S_SPEED;
}

static void mil_tracker_stop_recording()
{
  trackMillis = 0;
}

//static void mil_tracker_record_distance()
//{
//  std_io_print_distance(currentDistanceCm);
//}
