#include <stdio.h>
#include <at89lp51rd2.h>

#include "../libs/util.h"
#include "../libs/yap.h"

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

unsigned char _c51_external_startup(void)
{
	// Configure ports as a bidirectional with internal pull-ups.
	P0M0=0;	P0M1=0;
	P1M0=0;	P1M1=0;
	P2M0=0;	P2M1=0;
	P3M0=0;	P3M1=0;
	AUXR=0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	P4M0=0;	P4M1=0;
    
    // Initialize the serial port and baud rate generator
    PCON|=0x80;
	SCON = 0x52;
    BDRCON=0;
    BRL=BRG_VAL;
    BDRCON=BRR|TBCK|RBCK|SPD;
	
	return 0;
}

void main (void)
{
	unsigned char command;
	unsigned int adc;

	while(1) {
		wait_bit_time();
		adc = getADC(1);
		printf("ADC: %u\r\n", adc);
		/*
		if(adc <= BACKGROUND0_B) {
			printf("ADC: %u\r\n", adc);
			command = yap_receive(BACKGROUND0_B);
			printf("\r\nReceive: %u", command);
		}
		*/
	}
}