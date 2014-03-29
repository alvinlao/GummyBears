/*
 *	testmotor.h
 *
 * 	Project2 header file
*/

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 10000L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

//Ports
#define PORT_LEFT0 P1_0
#define PORT_LEFT1 P1_1
#define PORT_RIGHT0 P1_2
#define PORT_RIGHT1 P1_3