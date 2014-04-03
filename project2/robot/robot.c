#include <stdio.h>
#include <at89lp51rd2.h>

#include "../libs/util.h"
#include "../libs/yap.h"
#include "../libs/inductor.h"
#include "../libs/command.h"
#include "../libs/motor.h"

#include "robot.h"

//These variables are used in the ISR
volatile unsigned char pwmcount;
volatile unsigned char pwmL1;
volatile unsigned char pwmL2;
volatile unsigned char pwmR1;
volatile unsigned char pwmR2;

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
	
	// Initialize timer 0 for ISR 'pwmcounter()' below
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
	
	PX0=1; // External interrupt priorty
	PX1=1;
	EX0=0;
	EX1=0;
		//EX0=1; // Enable external interrupt 0 (P3.2)
	//EX1=1; // Enable external interrupt 1 (P3.3)
	
	EA=1;  // Enable global interrupts
	
	
	pwmcount=0;
    
    return 0;
}

// Interrupt 1 is for timer 0.  This function is executed every time
// timer 0 overflows: 100 us.
void pwmcounter (void) interrupt 1
{
	if(++pwmcount>99) pwmcount=0;
	
	//Left wheel
	PORT_LEFT_WHEEL0=(pwmL1>pwmcount)?1:0;
	PORT_LEFT_WHEEL1=(pwmL2>pwmcount)?1:0;
	
	//Right wheel
	PORT_RIGHT_WHEEL0=(pwmR1>pwmcount)?1:0;
	PORT_RIGHT_WHEEL1=(pwmR2>pwmcount)?1:0;
}

void frontdetector (void) interrupt 0 {
	//PORT_LED1 = 1;
	//while(!P3_2);	//Block
	//move(STOP, 0);
	//PORT_LED1 = 0;
}

void backdetector (void) interrupt 2 {
	//PORT_LED2 = 1;
	//while(P3_3);
	//move(STOP, 0);
	//PORT_LED2 = 0;
}

void main (void)
{	
	unsigned char newcommand, command = COMMAND_FOLLOW0;
	unsigned int leftB, rightB;
	
	printf("\r\nRobot Ready\r\n");
	/*
	//Calibration	
	while(1) {
		leftB = getLeftBField();
		rightB = getRightBField();
		printf("\r\nLeft: %4u  Right: %4u", leftB, rightB);
		wait_bit_time();
	}
	*/
	/*
	//Test receiver
	while(1) {
		if(getADC(INDUCTOR_LEFT) <= INDUCTOR_LEFT_BGB) {
			command = yap_receive(INDUCTOR_LEFT_BGB);
			printf("Command: %u\r\n", command);
		}
	}
	*/
	//Test motor
	/*
	while(1) {
		printf("\r\nCommand (0 move, 1 rotate): ");
		scanf("%du", &command);
		switch(command) {
			case 0:
				printf("\r\nDirection: ");
				scanf("%du", &command);
				move(command, 100);
				break;
			case 1:
				printf("\r\nDirection: ");
				scanf("%du", &command);
				rotate(command, 50);
				break;
		}
	}
	*/
	
	//Main
	PORT_LED0 = 0;
	PORT_LED1 = 0;
	move(STOP, 0);
	while(1) {
		leftB = getLeftBField();
		if(leftB <= INDUCTOR_YAP_MIN) {
			//STOP
			move(STOP, 0);
			PORT_LED0 = 1;
			PORT_LEFT_WHEEL0=0;
			PORT_LEFT_WHEEL1=0;
			
			//Right wheel
			PORT_RIGHT_WHEEL0=0;
			PORT_RIGHT_WHEEL1=0;
			newcommand = yap_receive(INDUCTOR_YAP_MIN);
			if(validCommand(newcommand)) {
				command = newcommand;
				printf("Command: %u\r\n", command);
			} else {
				printf("Invalid Command: %u\r\n", newcommand);
			}
			PORT_LED0 = 0;
		} else {
			//brain.c
			rightB = getRightBField();
			thinkAndDo(&command, leftB, rightB);
		}
	}
	
}