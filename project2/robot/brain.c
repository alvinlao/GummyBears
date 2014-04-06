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
		case COMMAND_REVERSEPARK:
			return 1;
		case COMMAND_MODE:
			return 1;
		case COMMAND_FORWARD:
			return 1;
		case COMMAND_BACKWARD:
			return 1;
		case COMMAND_LEFT:
			return 1;
		case COMMAND_RIGHT:
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
		case COMMAND_REVERSEPARK:
			reverseParallelPark();
			*command = COMMAND_STOP;
			break;
		case COMMAND_MODE:
			//Switch modes
			if(mode == AUTO) mode = MANUAL;
			else mode = AUTO;
			break;
		default:
			move(STOP, 0);
			*command = COMMAND_STOP;
			break;
	}
	return;
}

void manual(int direction) {
	switch(direction) {
		case COMMAND_FORWARD:
			move(FORWARD, 100);
			break;
		case COMMAND_BACKWARD:
			move(BACKWARD, 100);
			break;
		case COMMAND_LEFT:
			rotate(COUNTERCLOCKWISE, 100);
			break;
		case COMMAND_RIGHT:
			rotate(CLOCKWISE, 100);
			break;
		default:
			move(STOP, 0);
			break;
	}
}

void align(int leftD, int rightD) {
	int speed;
	if(leftD > rightD) {
		//printf("\r\nLeft edge closer");
		
		//Rotate slower when almost aligned
		if(leftD - rightD > 5) speed = 40;
		else speed = 20;
		
		rotate(CLOCKWISE, speed);
	} else if(leftD < rightD) {
		//printf("\r\nRight edge closer");
		
		//Rotate slower when almost aligned
		if(rightD - leftD > 5) speed = 40;
		else speed = 20;
		
		rotate(COUNTERCLOCKWISE, speed);
	} else {
		//printf("\rDon't know what to do");
		move(STOP, 0);
	}
}
char isAligned(int leftDistance, int rightDistance, int alignError) {
	int delta;
	delta = leftDistance - rightDistance;
	delta = delta < 0 ? (delta*-1) : delta;
	
	if(delta <= alignError)
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
	int leftD, rightD, speed;
	if(leftB <= INDUCTOR_LEFT_BGB || rightB <= INDUCTOR_RIGHT_BGB)
	return;
		
	leftD = getLeftDistance(leftB);
	rightD = getRightDistance(rightB);
	rightD = calibrate(rightD);
	if(leftD > 45) rightD += 5;
	
	//Display distance
	printf("\rLeft: %4d  Right: %4d", leftD, rightD);
	
	if(isAligned(leftD, rightD, ALIGNERROR)) {
		if(isCorrectDistanceAway(leftD, targetD)) {
			//printf("\r\nJust right left: %4d target: %4d", leftD, targetD);
			move(STOP, 0);
		} else if(leftD < targetD) {
			//printf("\r\nToo close left: %4d target: %4d", leftD, targetD);
			
			//Slow down when almost there
			if(targetD - leftD > 5) speed = 100;
			else speed = 80;

			PORT_LED1 = 0;
			move(BACKWARD, speed);
		} else {
			//printf("\r\nToo far left: %4d target: %4d", leftD, targetD);
			
			//Slow down when almost there
			if(leftD - targetD > 5) speed = 100;
			else speed = 80;
			
			if(PORT_PROX_FRONT) {
				PORT_LED1 = 1;
				move(STOP,0);
			} else {
				PORT_LED1 = 0;
				move(FORWARD, speed);
			}
		}
	} else {
		align(leftD, rightD);
	}
}

/*
 * Rotates the cart 180 degrees
 *
 * @requires 	The cart must be aligned with the magnetic field prior to rotating
 * @modifies	The cart is facing the opposite direction (properly aligned)
 */
void rotate180(char direction, unsigned int leftB, unsigned int rightB) {
	int speed;
	if(direction == CLOCKWISE) speed = 34;
	else speed = 32;
	
	rotate(direction, speed);
	wait1s();
	wait1s();
	wait1s();
	waithalfs();
	move(STOP, 0);
	return;
}

void parallelPark() {
	rotate(COUNTERCLOCKWISE, 35);
	wait1s();
	move(BACKWARD, 70);
	wait1s();
	wait1s();
	rotate(CLOCKWISE, 29);
	wait1s();
	move(STOP,0);
	return;
}

void reverseParallelPark() {;
	rotate(COUNTERCLOCKWISE, 35);
	wait1s();
	move(FORWARD, 70);
	wait1s();
	wait1s();
	rotate(CLOCKWISE, 30);
	wait1s();
	move(STOP,0);
	
	return;
}