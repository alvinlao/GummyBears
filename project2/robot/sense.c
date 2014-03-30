/* 
 * sense.c
 * 
 * Magnetic field detector
*/

#include <stdio.h>

#include "robot.h"
#include "../libs/util.h"

/*
 * Gets the left magnetic field strength
 * 
 * @requires 				The left inductor is channel 0 on the ADC
 * @return unsigned int 	The peak magnetic strength (0 - 1024)
 */
unsigned int getLeftBField() {
	// TODO: Correct timing with mag field freq to read peak
	unsigned int field = getADC(0);
	return 0;
}

/*
 * Gets the right magnetic field strength
 *
 * @requires 				The left inductor is channel 1 on the ADC
 * @return unsigned int 	The peak magnetic strength (0 - 1024)
 */
unsigned int getRightBField() {
	unsigned int field = getADC(1);
	return 0;
}

/*
 * Returns normalized left and right B fields
 *
 * Note:  	Since the two inductors (left and right) are exactly the same,
 *			their readings differ even if they are the same distance from
 * 			the transmitter. This function normalizes the two B fields.
 *
 */
void normalizeBFields(unsigned int *left, unsigned int *right) {
	return;
}