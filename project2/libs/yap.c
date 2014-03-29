#include <at89lp51rd2.h>

#include "yap.h"
#include "util.h"

//Private function
void wait_bit_time() {
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #4
	L3:	mov R1, #250
	L2:	mov R0, #184
	L1:	djnz R0, L1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R1, L2 ; 200us*250=0.05s
	    djnz R2, L3 ; 0.05s*2=0.1s
	    ret
    _endasm;
	return;
}

//Private function
void wait_one_and_half_bit_time() {
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
			mov R2, #6
	L13:	mov R1, #250
	L12:	mov R0, #184
	L11:	djnz R0, L1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    djnz R1, L2 ; 200us*250=0.05s
	    djnz R2, L3 ; 0.05s*3=0.15s
	    ret
    _endasm;
	return;
}

/*
 * Send one byte over magnetic field
 * Method: Bit bang (on/off modulation)
 *
 * @param val byte to send
 *
 */
void yap_send(unsigned char val) {
	unsigned char j;
	EA = 0; //Disable interrupts
	
	//Send the start bit
	wait_bit_time();
	for(j=0;j<8;++j) {
		EA = val&(0x01<<j)?1:0;
		wait_bit_time();
	}
	EA = 1;
	//Send the stop bits
	wait_bit_time();
	wait_bit_time();
}

/*
 * Receive one byte over magnetic field
 * Method: Bit bang (on/off modulation)
 *
 * @param min background noise
 * @return value 	received byte
 */
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
	wait_bit_time();
	
	EA = 1; //Enable interrupts
	return val;
}
