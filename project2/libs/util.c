#include <at89lp51rd2.h>

#include "util.h"

void SPIWrite(unsigned char value)
{
	SPSTA&=(~SPIF); // Clear the SPIF flag in SPSTA
	SPDAT=value;
	while((SPSTA & SPIF)!=SPIF); //Wait for transmission to end
}


/*
 * Gets the ADC value at selected channel
 * 
 * @requires MISO 	P1.5
 *			 SCK	P1.6
 *			 MOSI	P1.7
 *			 CE*	P1.4
 *
 * @param channel 0 - 3
 * @return unsigned int 10 bit reading
 */
unsigned int getADC(unsigned char channel)
{
	unsigned int adc;

	// initialize the SPI port to read the MCP3004 ADC attached to it.
	SPCON&=(~SPEN); // Disable SPI
	SPCON=MSTR|CPOL|CPHA|SPR1|SPR0|SSDIS;
	SPCON|=SPEN; // Enable SPI
	
	P1_4=0; // Activate the MCP3004 ADC.
	SPIWrite(channel|0x18);	// Send start bit, single/diff* bit, D2, D1, and D0 bits.
	for(adc=0; adc<10; adc++); // Wait for S/H to setup
	SPIWrite(0x55); // Read bits 9 down to 4
	adc=((SPDAT&0x3f)*0x100);
	SPIWrite(0x55);// Read bits 3 down to 0
	P1_4=1; // Deactivate the MCP3004 ADC.
	adc+=(SPDAT&0xf0); // SPDR contains the low part of the result. 
	adc>>=4;
		
	return adc;
}

char map7seg(char ascii) {
	if(ascii == '0') {
		return 0x24;
	} else if(ascii == '1') {
		return 0xaf;
	} else if(ascii == '2') {
		return 0xe0;
	} else if(ascii == '3') {
		return 0xa2;
	} else if(ascii == '4') {
		return 0x2b;
	} else if(ascii == '5') {
		return 0x32;
	} else if(ascii == '6') {
		return 0x30;
	} else if(ascii == '7') {
		return 0xa7;
	} else if(ascii == '8') {
		return 0x20;
	} else if(ascii == '9') {
		return 0x23;
	} else if(ascii == 'p') {
		return 0x61;
	} else if(ascii == 'a') {
		return 0x21;
	} else if(ascii == '|') {
		return 0x2d; 
	} else if(ascii == 'c') {
		return 0x74; 
	} else if(ascii == 'l') {
		return 0x7c; 
	} else {
		return 0xFF;
	}	
}

void wait1s() {
	_asm	
		;For a 22.1184MHz crystal one machine cycle 
		;takes 12/22.1184MHz=0.5425347us
	    mov R2, #20
	wait1s_L3:		mov R1, #250
	wait1s_L2:	mov R0, #184
	wait1s_L1:		djnz R0, wait1s_L1 ; 2 machine cycles-> 2*0.5425347us*184=200us
	    			djnz R1, wait1s_L2 ; 200us*250=0.05s
	    			djnz R2, wait1s_L3 ; 0.05s*20=0.1s
	    ret
    _endasm;
	return;
}