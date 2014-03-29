/*
 *	testmotor.h
 *
 * 	Project2 header file
*/

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 10000L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

//Motor
#define FORWARD 0
#define BACKWARD 1
#define STOP 2
#define CLOCKWISE 1
#define COUNTERCLOCKWISE 0

extern volatile unsigned char pwmcount;
extern volatile unsigned char pwmL1;
extern volatile unsigned char pwmL2;
extern volatile unsigned char pwmR1;
extern volatile unsigned char pwmR2;

void rotate(int direction, int speed);
void move(int direction, int speed);