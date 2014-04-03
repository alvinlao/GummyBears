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
#define FOLLOW_DISTANCE0 20
#define FOLLOW_DISTANCE1 29
#define FOLLOW_DISTANCE2 40
#define FOLLOW_DISTANCE3 54

//Ports
#define PORT_LEFT_WHEEL0 P2_0
#define PORT_LEFT_WHEEL1 P2_1
#define PORT_RIGHT_WHEEL0 P2_2
#define PORT_RIGHT_WHEEL1 P2_3

#define PORT_LED0 P2_4
#define PORT_LED1 P2_5
#define PORT_LED2 P2_6

#define PORT_PROX_FRONT P1_2
#define PORT_PROX_BACK P1_3

//brain.c
char validCommand(unsigned char c);
void thinkAndDo(unsigned char *command, unsigned int leftB, unsigned int rightB);
void maintainDistance(int distance, unsigned int leftB, unsigned int rightB);
void rotate180(char direction, unsigned int leftB, unsigned int rightB);
void parallelPark();
void reverseParallelPark();

//sense.c
unsigned int getLeftBField();
unsigned int getRightBField();
int getLeftDistance(unsigned int leftB);
int getRightDistance(unsigned int rightB);

#endif