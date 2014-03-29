/*
 *	robot.h
 *
 * 	Project2 header file
*/

#define CLK 22118400L
#define BAUD 115200L
#define BRG_VAL (0x100-(CLK/(32L*BAUD)))

#define FREQ 10000L
#define TIMER0_RELOAD_VALUE (65536L-(CLK/(12L*FREQ)))

//brain.c
void thinkAndDo(unsigned char command);
void maintainDistance(int distance);
void rotate180();
void parallelPark();
unsigned int dtoB(unsigned int distance);

//sense.c
unsigned int getLeftBField();
unsigned int getRightBField();
