#include "robot.h"
#include "../libs/util.h"
#include "../libs/yap.h"

//How accurate do we have to be for distance to beacon? (cm)
#define DISTANCEERROR 5
//How accurate is our magnetic field strength sensor?
#define BERROR 5
//The constant (determined by experiment) for |B| = c/r^3
#define INDUCTORCONSTANT 1

/*
 * Moves the robot based on command and current position in magnetic field
 *
 * @param unsigned char		ENUM
 */
void thinkAndDo(unsigned char command) {
	/* ENUM - available commands
	 *
	 * 101 - Maintain distance: 10cm
	 * 102 - Maintain distance: 20cm
	 * 103 - Maintain distance: 30cm
	 * 104 - Maintain distance: 40cm
	 * 
	 * 180 - Rotate 180 degrees
	 *
	 * 204 - Parallel park
	 */
	switch(command) {
		case 101:
			maintainDistance(10);
			break;
		case 102:
			maintainDistance(20);
			break;
		case 103:
			maintainDistance(30);
			break;
		case 104:
			maintainDistance(40);
			break;
		case 180:
			rotate180();
			break;
		case 204:
			parallelPark();
			break;
		default:
			break;
	}
	return;
}

char isAligned(unsigned int leftB, unsigned int rightB) {
	return 1;
}

char isCorrectDistanceAway(unsigned int realB, unsigned int targetB) {
	return 1;
}

/*
 * Maintains the given distance from beacon
 *
 * @requires sense.c
 * @modifies			When the function exits, the robot is properly aligned with beacon at desired distance
 * @param distance		The desired distance in cm
 */
void maintainDistance(int distance) {
	unsigned int leftB, rightB, targetB;
	
	leftB = getLeftBField();
	rightB = getRightBField();

	if(isAligned(leftB, rightB)) {
		targetB = dtoB(distance);
		
		if(isCorrectDistanceAway(leftB, targetB)) {
			move(STOP, 0);
		} else if(leftB > targetB) {
			move(BACKWARD, 100);
		} else {
			move(FORWARD, 100);
		}
	} else if(leftB > rightB) {
		rotate(COUNTERCLOCKWISE, 100);
	} else {
		rotate(CLOCKWISE, 100);
	}
}

/*
 * Rotates the cart 180 degrees
 *
 * @requires 	The cart must be aligned with the magnetic field prior to rotating
 * @modifies	The cart is facing the opposite direction (properly aligned)
 */
void rotate180() {
	unsigned int leftB, rightB;

	rotate(CLOCKWISE, 100);	//Unalign cart
	//Keep rotating until aligned
	while(1) {
		leftB = getLeftBField();
		rightB = getRightBField();
		
		if(leftB <= rightB + BERROR && leftB >= rightB - BERROR) {
			break;
		} else {
			rotate(CLOCKWISE, 100);
		}
	}
	return;
}

void parallelPark() {
	unsigned int leftB, rightB;
	leftB = getLeftBField();
	rightB = getRightBField();

	//TODO
	return;
}

/*
 * Converts distance to magnetic field strength
 * 
 * @param unsigned int d		distance in cm
 * @return unsigned int B		magnetic field strength (0 - 1023)
 */
unsigned int dtoB(unsigned int d) {	
	return INDUCTORCONSTANT/(d*d*d);
}