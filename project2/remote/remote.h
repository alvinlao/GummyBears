/*
 *	remote.h
 *
 * 	Project2 remote header file
*/
#ifndef _REMOTE_H
#define _REMOTE_H

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 30650L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))


#define MANUAL	0
#define AUTO	1

//Ports
#define PUSH_0 P4_0
#define PUSH_1 P4_1
#define PUSH_2 P4_2
#define PUSH_3 P4_3
#define PUSH_4 P4_4

//7 seg ports
#define PORT_SEG_A P2
#define PORT_SEG_B P1

//Inductor H-Bridge ports
#define PORT_TRANSMIT_0 P0_0
#define PORT_TRANSMIT_1 P0_1

extern char mode;

//command.c
unsigned char getNextCommand(unsigned char currentcommand);
void displaycommand(unsigned char c);
void manualCommand();

#endif
