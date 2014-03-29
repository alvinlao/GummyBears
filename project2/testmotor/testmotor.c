#include <stdio.h>
#include <at89lp51rd2.h>

#include "../libs/util.h"
#include "../libs/yap.h"
#include "testmotor.h"

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 30650L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

//Ports
#define INDUCTOR_0 P1_0
#define INDUCTOR_1 P1_1

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
	
	// Initialize timer 0 for ISR 'square_wave_generator()' below
	TR0=0; // Stop timer 0
	TMOD=0x01; // 16-bit timer
	// Use the autoreload feature available in the AT89LP51RB2
	// WARNING: There was an error in at89lp51rd2.h that prevents the
	// autoreload feature to work.  Please download a newer at89lp51rd2.h
	// file and copy it to the crosside\call51\include folder.
	TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	TR0=1; // Start timer 0 (bit 4 in TCON)
	ET0=1; // Enable timer 0 interrupt
	EA=1;  // Enable global interrupts
    
    return 0;
}

// Interrupt 1 is for timer 0.  This function is executed every time
// timer 0 overflows: 15.9 kHz
void square_wave_generator (void) interrupt 1
{
	if(INDUCTOR_0 == 1) {
		INDUCTOR_0 = 0;
		INDUCTOR_1 = 1;
	} else { 
		INDUCTOR_0 = 1;
		INDUCTOR_1 = 0;
	}
	return;
}

void main (void)
{
	unsigned char command;
	
	while(1) {
		printf("\r\nSend: ");
		scanf("%du", &command);
		yap_send(command);
	}
}