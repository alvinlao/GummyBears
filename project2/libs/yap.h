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
