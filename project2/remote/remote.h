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


//Ports
#define PUSH_0 P4_0
#define PUSH_1 P4_1
#define PUSH_2 P4_2
#define PUSH_3 P4_3

#define PORT_TRANSMIT_0 P0_1
#define PORT_TRANSMIT_1 P0_3

//command.c
unsigned char getNextCommand(unsigned char currentcommand);
void displaycommand(unsigned char c);

#endif
