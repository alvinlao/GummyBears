// Time for each bit (in milliseconds)
#define BITTIME 100

/*
 * Gets the ADC value at selected channel
 * 
 * @requires channel 0 = P2.0
 *			 channel 1 = P2.1
 *			 channel 2 = P2.2
 *			 channel 3 = P2.3
 * @param channel 0 - 3
 * @return 10 bit reading
 */
unsigned int getADC(char channel);

/*
 * Wait for BITTIME and BITTIME*1.5
 */
void wait_bit_time();
void wait_one_and_half_bit_time();
