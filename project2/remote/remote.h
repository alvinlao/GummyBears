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

#define FREQ 31840L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

#endif
