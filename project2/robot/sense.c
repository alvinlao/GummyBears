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
 * Gets the left magnetic field strength
 * 
 * @requires 				The left inductor is channel 0 on the ADC
 * @return unsigned int 	The peak magnetic strength (0 - 1024)
 */
unsigned int getLeftBField() {
	return getADC(0);
}

/*
 * Gets the right magnetic field strength
 *
 * @requires 				The left inductor is channel 1 on the ADC
 * @return unsigned int 	The peak magnetic strength (0 - 1024)
 */
unsigned int getRightBField() {
	return getADC(1);
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
	*left -= INDUCTOR_BGB0;
	*right -= INDUCTOR_BGB1;
}