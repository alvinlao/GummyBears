/*
 *	robot.h
 *
 * 	Project2 header file
*/

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

//We want timer 0 to interrupt every 100 microseconds ((1/10000Hz)=100 us)
#define FREQ 10000L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

extern volatile unsigned char pwmcount;
extern volatile unsigned char pwmL1;
extern volatile unsigned char pwmL2;
extern volatile unsigned char pwmR1;
extern volatile unsigned char pwmR2;

/********************************************************************
	motor.c
*********************************************************************/

/*
 * Rotate the robot
 *
 * @requires pwmL1, pwmL2, pwmR1, pwmR2
 * @modifies pwmL1, pwmL2, pwmR1, pwmR2
 *
 * @param direction 0 - clockwise, 1 - counter-clockwise
 * @param speed		0 - 100
 *
 */
void rotate(int direction, int speed);

/*
 * Move the robot forwards/backwards
 *
 * @param direction 0 - forwards, 1 - backwards
 * @param speed		0 - 100
 */
void move(int direction, int speed);
 
