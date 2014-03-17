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
 * @param 	degrees		Bearing is relative to the front of the robot.
						Degree is positive clock-wise
 *						units: ?
 */
void rotate(int degrees);

/*
 * Move the robot forwards/backwards
 *
 * @param 	distance	positive is forwards, negative is backwards
 *						units: ?
 */
void move(int distance);
 