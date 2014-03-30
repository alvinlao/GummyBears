/*
 *	robot.h
 *
 * 	Project2 header file
*/
#ifndef _ROBOT_H_
#define _ROBOT_H_

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 10000L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

//Follow distances
#define FOLLOW_DISTANCE0 10
#define FOLLOW_DISTANCE1 20
#define FOLLOW_DISTANCE2 30
#define FOLLOW_DISTANCE3 40

//Ports
#define PORT_LEFT_WHEEL0 P2_0
#define PORT_LEFT_WHEEL1 P2_1
#define PORT_RIGHT_WHEEL0 P2_2
#define PORT_RIGHT_WHEEL1 P2_3


//brain.c
void thinkAndDo(unsigned char command);
void maintainDistance(int distance);
void rotate180(char direction);
void parallelPark();

//sense.c
unsigned int getLeftBField();
unsigned int getRightBField();
void normalizeBFields(unsigned int *left, unsigned int *right);
unsigned int dtoB(unsigned int d);

#endif