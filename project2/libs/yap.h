#ifndef _YAP_H_
#define _YAP_H_

#define INDUCTOR_0 P1_0
#define INDUCTOR_1 P1_1

/*
 * Send one byte over magnetic field
 * Method: Bit bang (on/off modulation)
 *
 * @requires P2.0 output pin
 * @param val byte to send
 *
 */
void yap_send(unsigned char val);

/*
 * Receive one byte over magnetic field
 * Method: Bit bang (on/off modulation)
 *
 * @param min ?
 * @return value 	received byte
 */
unsigned char yap_receive(int min);

#endif