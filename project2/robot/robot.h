/*
 *	robot.h
 *
 * 	Project2 header file
*/

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 10000L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

//robot.c
extern volatile unsigned char pwmcount;
extern volatile unsigned char pwmL1;
extern volatile unsigned char pwmL2;
extern volatile unsigned char pwmR1;
extern volatile unsigned char pwmR2;

//motor.c
void rotate(int direction, int speed);
void move(int direction, int speed);

//brain.c
void think();