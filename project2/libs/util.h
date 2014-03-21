// Time for each bit (in milliseconds)
#define BITTIME 100

/*
 * Gets the ADC value at selected channel
 * 
 * @requires MISO 	P1.5
 *			 SCK	P1.6
 *			 MOSI	P1.7
 *			 CE*	P1.4
 *
 * @param channel 0 - 3
 * @return 10 bit reading
 */
unsigned int getADC(unsigned char channel);

/*
 * Wait for BITTIME and BITTIME*1.5
 */
void wait_bit_time();
void wait_one_and_half_bit_time();
