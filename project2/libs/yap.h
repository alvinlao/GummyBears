#ifndef _YAP_H_
#define _YAP_H_

void yap_send(unsigned char val);
unsigned char yap_receive(int min);

void wait_bit_time();
void wait_one_and_half_bit_time();

#endif