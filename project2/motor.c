#include "robot.h"

void rotate(int direction, int speed) {
	if(direction == 0) {
		//Clockwise
		pwmL1 = speed;
		pwmL2 = 0;
		pwmR1 = 0;
		pwmR2 = speed;
	} else {
		//Counter clockwise
		pwmL1 = 0;
		pwmL2 = speed;
		pwmR1 = speed;
		pwmR2 = 0;
	}
}

void move(int direction, int speed) {
	if(direction == 0) {
		//Fowards
		pwmL1 = speed;
		pwmL2 = 0;
		pwmR1 = speed;
		pwmR2 = 0;
	} else {
		//Backwards
		pwmL1 = 0;
		pwmL2 = speed;
		pwmR1 = 0;
		pwmR2 = speed;
	}
}
