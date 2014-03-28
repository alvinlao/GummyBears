/*
 *	remote.h
 *
 * 	Project2 remote header file
*/
#ifndef REMOTE_H
#define REMOTE_H

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 30650L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))


//ports
#define INDUCTOR_0 P0_0
#define INDUCTOR_1 P0_1

//command.c
unsigned char getNextCommand(unsigned char currentcommand);
void displaycommand(unsigned char c);

#endif
