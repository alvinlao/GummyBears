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
	
	EX0=0;
	EX1=0;

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


void main (void)
{	
	unsigned char newcommand, command = COMMAND_FOLLOW0;
	int newdirection, direction = COMMAND_STOP;
	unsigned int leftB, rightB;
	
	printf("\r\nRobot Ready\r\n");
	//Main
	PORT_LED0 = 0;
	PORT_LED1 = 0;
	move(STOP, 0);
	while(1) {
		if(mode == AUTO) {
			printf("Enter AUTO mode\n");
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
		} else {
			leftB = getLeftBField();
			if(leftB <= INDUCTOR_YAP_MIN) {
				//Stop moving
				move(STOP, 0);
				PORT_LED0 = 1;
				PORT_LEFT_WHEEL0=0;
				PORT_LEFT_WHEEL1=0;
				PORT_RIGHT_WHEEL0=0;
				PORT_RIGHT_WHEEL1=0;
				
				//Get direction
				newdirection = yap_receive(INDUCTOR_YAP_MIN);
				if(validCommand(newdirection)) {
					direction = newdirection;
					printf("Direction: %u\r\n", direction);
					
					//Check switch back to auto
					if(direction == COMMAND_MODE) {
						printf("Exit MANUAL mode\n");
						mode = AUTO;
						command = newcommand = COMMAND_STOP;
					} else {
						//Set movement
						manual(direction);
						wait_bit_time();
						while(1) {
							leftB = getLeftBField();
							if(leftB > INDUCTOR_YAP_MIN) {
								move(STOP, 0);
								PORT_LED0 = 0;
								break;
							}
						}
					}	
				} else {
					printf("Invalid Direction: %u\r\n", newdirection);
				}
			}
		}
	}
	
}