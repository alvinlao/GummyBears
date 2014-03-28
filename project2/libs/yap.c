#include <at89lp51rd2.h>
#include "yap.h"
#include "util.h"

void yap_send(unsigned char val) {
	unsigned char j;
	EA = 0; //Disable interrupts
	
	//Send the start bit
	P2_0=0;
	wait_bit_time();
	for(j=0;j<8;++j) {
		P2_0=val&(0x01<<j)?1:0;
		wait_bit_time();
	}
	P2_0=1;
	//Send the stop bits
	wait_bit_time();
	wait_bit_time();
	
	EA = 1; //Enable interrupts
}


unsigned char yap_receive(int min) {
	unsigned char j, val;
	int v;
	EA = 0;	//Disable interrupts
	
	//Skip the start bit
	val=0;
	wait_one_and_half_bit_time();
	for(j=0;j<8;++j) {
		v=getADC(0);
		val|=(v>min)?(0x01<<j):0x00;
		wait_bit_time();
	}
	//Wait for stop bits
	wait_one_and_half_bit_time();
	
	EA = 1; //Enable interrupts
	return val;
}
