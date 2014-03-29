#ifndef _MOTOR_H_
#define _MOTOR_H_

#define FORWARD 0
#define BACKWARD 1
#define STOP 2
#define CLOCKWISE 1
#define COUNTERCLOCKWISE 0

//ISR variables
extern volatile unsigned char pwmcount;
extern volatile unsigned char pwmL1;
extern volatile unsigned char pwmL2;
extern volatile unsigned char pwmR1;
extern volatile unsigned char pwmR2;

//motor.c
void rotate(int direction, int speed);
void move(int direction, int speed);

#endif