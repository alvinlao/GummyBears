/* 
 * sense.c
 * 
 * Magnetic field detector
*/

#include <stdio.h>

#include "robot.h"
#include "../libs/util.h"
#include "../libs/inductor.h"

/*
 *
 * Gets the left magnetic field strength
 * 
 * @return unsigned int 	The peak magnetic strength (0 - 1024)
 */
unsigned int getLeftBField() {
	return getADC(INDUCTOR_LEFT);
}

/*
 *
 * Gets the right magnetic field strength
 *
 * @return unsigned int 	The peak magnetic strength (0 - 1024)
 */
unsigned int getRightBField() {
	return getADC(INDUCTOR_RIGHT);
}

/*
 * Private
 *
 * Converts B field reading to a distance
 *
 * NOTE: Adjust this function's coefficients in "inductor.h"
 *  
 * @param inductor	ENUM - INDUCTOR_LEFT or INDUCTOR_RIGHT (inductor.h)
 * @param B			ADC B field reading
 * @return int		Distance from emitter
 *
 */
int Btod(char inductor, unsigned int B) {
	switch(inductor) {
		case INDUCTOR_LEFT:
			if(B < INDUCTOR_LEFT_BGB) return 0;
			return ((INDUCTOR_LEFT_P1)*B*B*B + (INDUCTOR_LEFT_P2)*B*B + (INDUCTOR_LEFT_P3)*B + (INDUCTOR_LEFT_P4));
		case INDUCTOR_RIGHT:
			if(B < INDUCTOR_RIGHT_BGB) return 0;
			return ((INDUCTOR_RIGHT_P1)*B*B*B + (INDUCTOR_RIGHT_P2)*B*B + (INDUCTOR_RIGHT_P3)*B + (INDUCTOR_RIGHT_P4));
		default:
			return 0;
	}
}

//public
int getLeftDistance(unsigned int leftB) {
	return Btod(INDUCTOR_LEFT, leftB);
}

//public
int getRightDistance(unsigned int rightB) {
	return Btod(INDUCTOR_RIGHT, rightB);
}