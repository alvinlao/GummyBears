// Time for each bit (in milliseconds)
#define BITTIME 100

/*
 * Send one byte over magnetic field
 * Method: Bit bang (on/off modulation)
 *
 * @param val byte to send
 *
 */
void yap_send(unsigned char val);

/*
 * Receive one byte over magnetic field
 * Method: Bit bang (on/off modulation)
 *
 * @param min ?
 *
 */
void yap_receive(int min);

/*
 * The time length of each bit
 */
void yap_wait_bit();
void yap_wait_half_bit();

