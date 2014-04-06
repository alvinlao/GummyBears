#include <stdio.h>
#include <at89lp51rd2.h>

#include "remote.h"

#include "../libs/yap.h"
#include "../libs/util.h"
#include "../libs/command.h"

char mode = AUTO;

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
	if(PORT_TRANSMIT_0 == 1) {
		PORT_TRANSMIT_0 = 0;
		PORT_TRANSMIT_1 = 1;
	} else { 
		PORT_TRANSMIT_0 = 1;
		PORT_TRANSMIT_1 = 0;
	}
}

void test7segs(void) {
	PORT_SEG_A = map7seg('0');
	PORT_SEG_B = map7seg('0');
	wait1s();
	PORT_SEG_A = map7seg('1');
	PORT_SEG_B = map7seg('1');
	wait1s();
	PORT_SEG_A = map7seg('2');
	PORT_SEG_B = map7seg('2');
	wait1s();
	PORT_SEG_A = map7seg('3');
	PORT_SEG_B = map7seg('3');
	wait1s();
	PORT_SEG_A = map7seg('4');
	PORT_SEG_B = map7seg('4');
	wait1s();
	PORT_SEG_A = map7seg('5');
	PORT_SEG_B = map7seg('5');
	wait1s();
	PORT_SEG_A = map7seg('6');
	PORT_SEG_B = map7seg('6');
	wait1s();
	PORT_SEG_A = map7seg('7');
	PORT_SEG_B = map7seg('7');
	wait1s();
	PORT_SEG_A = map7seg('8');
	PORT_SEG_B = map7seg('8');
	wait1s();
	PORT_SEG_A = map7seg('9');
	PORT_SEG_B = map7seg('9');
	wait1s();
	PORT_SEG_A = map7seg('?');
	PORT_SEG_B = map7seg('?');
	wait1s();
	PORT_SEG_A = map7seg('p');
	PORT_SEG_B = map7seg('p');
	wait1s();	
	PORT_SEG_A = map7seg('a');
	PORT_SEG_B = map7seg('a');
	wait1s();	
}

void main (void) {
	unsigned char prevcommand = COMMAND_FOLLOW0, command = COMMAND_FOLLOW0;

	//test7segs();
	/*
	while(1) {
		printf("\r\nSend: ");
		scanf("%du", &command);
		yap_send(command);
	}
	*/
	
	printf("\r\nRemote Ready\r\n");
	displaycommand(command);
	while(1) {
		if(mode == AUTO) {
			prevcommand = command;
			command = getNextCommand(prevcommand);	//Blocks until a button is pushed
			displaycommand(command); 	//Display command on 7 segs
			yap_send(command);			//Send command!
		} else {
			manualCommand();			//Blocks; Allows user to manually control robot
			mode = AUTO;
			displaycommand(COMMAND_MODE);
			yap_send(COMMAND_MODE);
		}
	}
}