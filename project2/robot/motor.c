#include <stdio.h>

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
		//printf("\r\nRotate CLOCKWISE");
		pwmL1 = speed;
		pwmL2 = 0;
		pwmR1 = 0;
		pwmR2 = speed;
	} else if (direction == COUNTERCLOCKWISE) {
		//printf("\r\nRotate COUNTER-CLOCKWISE");
		pwmL1 = 0;
		pwmL2 = speed;
		pwmR1 = speed;
		pwmR2 = 0;
	} else {
		//printf("\r\nRotate STOP");
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
		//printf("\r\nMove BACKWARD");
		pwmL1 = speed+5;
		pwmL2 = 0;
		pwmR1 = speed;
		pwmR2 = 0;
	} else if(direction == FORWARD){
		//printf("\r\nMove FORWARD");
		pwmL1 = 0;
		pwmL2 = speed;
		pwmR1 = 0;
		pwmR2 = speed+8;
	} else {
		//printf("\r\nMove STOP");
		pwmL1 = pwmL2 = pwmR1 = pwmR2 = 0;
	}
}
