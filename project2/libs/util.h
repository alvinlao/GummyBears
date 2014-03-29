#ifndef _UTIL_H_
#define _UTIL_H_

#define SEG_A P2
#define SEG_B P3

//Inductor output with no B field (ADC output)
#define BACKGROUND0_B 20
#define BACKGROUND1_B 40

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

//7 Seg
void display7segs(char a, char b);

#endif