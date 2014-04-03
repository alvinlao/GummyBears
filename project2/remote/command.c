#include <stdio.h>
#include <at89lp51rd2.h>

#include "../libs/util.h"
#include "../libs/command.h"
#include "remote.h"

//Private function
char isFollow(unsigned char c) {
	if(c == COMMAND_FOLLOW0 ||
		c == COMMAND_FOLLOW1 ||
		c == COMMAND_FOLLOW2 ||
		c == COMMAND_FOLLOW3
	) return 1;
	
	else return 0;
}

//Private function
unsigned char nextFollowCommand(unsigned char c) {
	if(c == COMMAND_FOLLOW0) return COMMAND_FOLLOW1;
	else if(c == COMMAND_FOLLOW1) return COMMAND_FOLLOW2;
	else if(c == COMMAND_FOLLOW2) return COMMAND_FOLLOW3;
	else if(c == COMMAND_FOLLOW3) return COMMAND_FOLLOW0;
	else return COMMAND_FOLLOW0;
}

unsigned char getNextCommand(unsigned char currentCommand) {
	while(1) {
	//Cycle follow distance
		if(!PUSH_0) {
			while(!PUSH_0); //Wait for release
			
			//Cycle follow distance
			if(isFollow(currentCommand))
				return nextFollowCommand(currentCommand);
			else
				return COMMAND_FOLLOW0;
		}
		
		//180 Counter-Clockwise
		else if(!PUSH_1) {
			while(!PUSH_1); //Wait for release
			return COMMAND_180CC;
		}
		
		//180 Clockwise
		else if(!PUSH_2) {
			while(!PUSH_2); //Wait for release
			return COMMAND_180CL;
		}
		
		//Parallel and Reverse Park
		else if(!PUSH_3) {
			while(!PUSH_3); //Wait for release
			if(currentCommand == COMMAND_PARK)
				return COMMAND_REVERSEPARK;
			else
				return COMMAND_PARK;
		}
	}
}

//Private
void display7segs(char a, char b) {
	PORT_SEG_A = map7seg(a);
	PORT_SEG_B = map7seg(b);
}

void displaycommand(unsigned char c) {
	P4_4 = 1;
	if(c == COMMAND_FOLLOW0) display7segs('2', '0');
	else if(c == COMMAND_FOLLOW1) display7segs('3', '0');
	else if(c == COMMAND_FOLLOW2) {display7segs('4', '0'); P4_4 = 0;}
	else if(c == COMMAND_FOLLOW3) {display7segs('5', '0'); P4_4 = 0;}
	else if(c == COMMAND_180CC) {display7segs('c', 'c'); P4_4 = 0;}
	else if(c == COMMAND_180CL) {display7segs('c', 'l'); P4_4 = 0;}
	else if(c == COMMAND_PARK) {display7segs('|', '|'); P4_4 = 0;}
	else if(c == COMMAND_REVERSEPARK) {display7segs('?', '?'); P2_2=0;}
}