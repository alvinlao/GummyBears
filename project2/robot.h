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


/********************************************************************
	motor.c
*********************************************************************/

/*
 * Rotate the robot
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
 
