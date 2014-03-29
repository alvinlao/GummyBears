#include <at89lp51rd2.h>
#include "util.h"

void SPIWrite(unsigned char value)
{
	SPSTA&=(~SPIF); // Clear the SPIF flag in SPSTA
	SPDAT=value;
	while((SPSTA & SPIF)!=SPIF); //Wait for transmission to end
}

// Read 10 bits from the MCP3004 ADC converter
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


char map7seg(char ascii) {
	if(ascii == '0') {
		return 0xc0;
	} else if(ascii == '1') {
		return 0xF9;
	} else if(ascii == '2') {
		return 0xA4;
	} else if(ascii == '3') {
		return 0xB0;
	} else if(ascii == '4') {
		return 0x99;
	} else if(ascii == '5') {
		return 0x92;
	} else if(ascii == '6') {
		return 0x82;
	} else if(ascii == '7') {
		return 0xF8;
	} else if(ascii == '8') {
		return 0x80;
	} else if(ascii == '9') {
		return 0x90;
	} else if(ascii == 'n') {
		return 0xAB;
	} else if(ascii == 'u') {
		return 0xE3;
	} else if(ascii == 'p') {
		return 0x31;
	} else {
		return 0xFF;
	}	
}

void display7segs(char a, char b) {
	SEG_A = map7seg(a);
	SEG_B = map7seg(b);
}