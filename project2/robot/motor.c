#include "../libs/motor.h"

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
void rotate(int direction, int speed) {
	if(direction == CLOCKWISE) {
		pwmL1 = speed;
		pwmL2 = 0;
		pwmR1 = 0;
		pwmR2 = speed;
	} else if (direction == COUNTERCLOCKWISE) {
		pwmL1 = 0;
		pwmL2 = speed;
		pwmR1 = speed;
		pwmR2 = 0;
	} else {
		pwmL1 = pwmL2 = pwmR1 = pwmR2 = 0;
	}
}

/*
 * Move the robot forwards/backwards
 *
 * @param direction 0 - forward, 1 - backward, 2 - stop
 * @param speed		0 - 100
 */
void move(int direction, int speed) {
	if(direction == BACKWARD) {
		pwmL1 = speed+5;
		pwmL2 = 0;
		pwmR1 = speed;
		pwmR2 = 0;
	} else if(direction == FORWARD){
		pwmL1 = 0;
		pwmL2 = speed;
		pwmR1 = 0;
		pwmR2 = speed+8;
	} else {
		pwmL1 = pwmL2 = pwmR1 = pwmR2 = 0;
	}
}
