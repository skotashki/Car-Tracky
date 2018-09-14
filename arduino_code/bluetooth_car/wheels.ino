#define E1  3
#define E2  11
#define M1  12
#define M2  13

#define WHEEL_SPEED 150

static int speed = 0;
static bool isMoving = false;

void wheels_init()
{
  speed = WHEEL_SPEED;
  
  pinMode(M1,OUTPUT);
  pinMode(M2,OUTPUT);
  pinMode(E1,OUTPUT);
  pinMode(E2,OUTPUT);
}

void wheels_loop()
{
  int cmd = std_io_read_input();
  if (cmd == 'U') wheels_forward();
  else if (cmd == 'D') wheels_backwards();
  else if (cmd == 'L') wheels_left();
  else if (cmd == 'R') wheels_right();
  else if (cmd == 'S') wheels_stop();
}

int wheels_are_moving()
{
  return isMoving;
}

void wheels_left(void)
{
  digitalWrite(M1,LOW);
  digitalWrite(M2, LOW);
  setSpeed(speed);
  isMoving = true;
}

void wheels_right(void)
{
  digitalWrite(M1,HIGH);
  digitalWrite(M2, HIGH);
  setSpeed(speed);
  isMoving = true;
}

void wheels_forward(void)
{
  digitalWrite(M1,LOW);
  digitalWrite(M2,HIGH);
  setSpeed(speed);
  isMoving = true;
}
void wheels_backwards(void)
{
  digitalWrite(M1,HIGH);
  digitalWrite(M2, LOW);
  setSpeed(speed);
  isMoving = true;
}    
void wheels_stop(void)
{
  digitalWrite(M1,LOW);    
  digitalWrite(M2, LOW);  
  setSpeed(0);
  isMoving = false;
}

static void setSpeed(int speed)
{
  analogWrite(E1, speed);
  analogWrite(E2, speed);
}
