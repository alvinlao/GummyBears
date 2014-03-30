/*
 * yap.h
 * 
 * Communication using B field
 */
#ifndef _YAP_H_
#define _YAP_H_

void yap_send(unsigned char val);
unsigned char yap_receive(int min);

#endif