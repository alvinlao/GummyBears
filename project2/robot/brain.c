#include <stdio.h>
#include <at89lp51rd2.h>

#include "robot.h"
#include "../libs/util.h"
#include "../libs/yap.h"
#include "../libs/motor.h"
#include "../libs/command.h"
#include "../libs/inductor.h"


char validCommand(unsigned char c) {
	switch(c) {
		case COMMAND_FOLLOW0:
			return 1;
		case COMMAND_FOLLOW1:
			return 1;
		case COMMAND_FOLLOW2:
			return 1;
		case COMMAND_FOLLOW3:
			return 1;
		case COMMAND_180CL:
			return 1;
		case COMMAND_180CC:
			return 1;
		case COMMAND_PARK:
			return 1;
		default:
			return 0;
	}
}

/*
 * Moves the robot based on command and current position in magnetic field
 *
 * @param unsigned char		see command.h
 */
void thinkAndDo(unsigned char *command, unsigned int leftB, unsigned int rightB) {
	switch(*command) {
		case COMMAND_FOLLOW0:
			maintainDistance(FOLLOW_DISTANCE0, leftB, rightB);
			break;
		case COMMAND_FOLLOW1:
			maintainDistance(FOLLOW_DISTANCE1, leftB, rightB);
			break;
		case COMMAND_FOLLOW2:
			maintainDistance(FOLLOW_DISTANCE2, leftB, rightB);
			break;
		case COMMAND_FOLLOW3:
			maintainDistance(FOLLOW_DISTANCE3, leftB, rightB);
			break;
		case COMMAND_180CL:
			rotate180(CLOCKWISE, leftB, rightB);
			*command = COMMAND_STOP;
			break;
		case COMMAND_180CC:
			rotate180(COUNTERCLOCKWISE, leftB, rightB);
			*command = COMMAND_STOP;
			break;
		case COMMAND_PARK:
			parallelPark();
			*command = COMMAND_STOP;
			break;
		default:
			move(STOP, 0);
			*command = COMMAND_STOP;
			break;
	}
	return;
}

char isAligned(int leftDistance, int rightDistance) {
	int delta = leftDistance - rightDistance;
	delta = delta < 0 ? (delta*-1) : delta;
	
	if(delta <= DERROR)
		return 1;
	return 0;
}

char isCorrectDistanceAway(int currentDistance, int targetDistance) {
	int delta = currentDistance - targetDistance;
	delta = delta < 0 ? (delta*-1) : delta;
	
	if(delta <= DERROR)
		return 1;
	return 0;
}

int calibrate(int dr) {
	int y = (INDUCTOR_CALIBRATE_P1)*dr*dr*dr*dr + (INDUCTOR_CALIBRATE_P2)*dr*dr*dr + 
			(INDUCTOR_CALIBRATE_P3)*dr*dr + (INDUCTOR_CALIBRATE_P4)*dr + (INDUCTOR_CALIBRATE_P5);
	return y;
}

/*
 * Maintains the given distance from beacon
 *
 * @requires sense.c
 * @modifies			When the function exits, the robot is properly aligned with beacon at desired distance
 * @param distance		The desired distance in cm
 */
void maintainDistance(int targetD, unsigned int leftB, unsigned int rightB) {
	int leftD, rightD;
	if(leftB <= INDUCTOR_LEFT_BGB || rightB <= INDUCTOR_RIGHT_BGB)
	return;
		
	leftD = getLeftDistance(leftB);
	rightD = getRightDistance(rightB);
	rightD = calibrate(rightD);

	//Display distance
	printf("\rLeft: %4d  Right: %4d", leftD, rightD);
		
	if(isAligned(leftD, rightD)) {
		if(isCorrectDistanceAway(leftD, targetD)) {
			//printf("\r\nJust right left: %4d target: %4d", leftD, targetD);
			move(STOP, 0);
		} else if(leftD < targetD) {
			//printf("\r\nToo close left: %4d target: %4d", leftD, targetD);
			//Edge dection
			if(PORT_PROX_BACK) {
				PORT_LED1 = 1;
				move(STOP,0);
			} else {
				PORT_LED1 = 0;
				move(BACKWARD, 60);
			}
		} else {
			//printf("\r\nToo far left: %4d target: %4d", leftD, targetD);
			if(PORT_PROX_FRONT) {
				PORT_LED1 = 1;
				move(STOP,0);
			} else {
				PORT_LED1 = 0;
				move(FORWARD, 60);
			}
		}
	} else if(leftD > rightD) {
		//printf("\r\nLeft edge closer");
		rotate(CLOCKWISE, 30);
	} else if(leftD < rightD) {
		//printf("\r\nRight edge closer");
		rotate(COUNTERCLOCKWISE, 30);
	} else {
		//printf("\rDon't know what to do");
		move(STOP, 0);
	}
}

/*
 * Rotates the cart 180 degrees
 *
 * @requires 	The cart must be aligned with the magnetic field prior to rotating
 * @modifies	The cart is facing the opposite direction (properly aligned)
 */
void rotate180(char direction, unsigned int leftB, unsigned int rightB) {
	//Enable proximity interrupt
	int speed;
		
	//EX0 = 1; EX1 = 1;
	if(direction == CLOCKWISE) speed = 32;
	else speed = 31;
	
	rotate(direction, speed);
	wait1s();
	wait1s();
	wait1s();
	waithalfs();
	move(STOP, 0);
	
	//EX0 = 0; EX1 = 0;
	return;
}

void parallelPark() {
	//Enable proximity interrupt
	//EX0 = 1; EX1 = 1;
	
	rotate(COUNTERCLOCKWISE, 30);
	wait1s();
	move(BACKWARD, 50);
	wait1s();
	wait1s();
	rotate(CLOCKWISE, 27);
	wait1s();
	move(STOP,0);
	
	//EX0 = 0; EX1 = 0;
	return;
}