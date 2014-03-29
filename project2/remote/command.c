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
	//Cycle follow distance
	if(!PUSH_0 && isFollow(currentCommand)) {
		return nextFollowCommand(currentCommand);
	}
	//Follow
	else if(!PUSH_1) return COMMAND_FOLLOW0;
	//180
	else if(!PUSH_2) return COMMAND_180;
	//Parallel Park
	else if(!PUSH_3) return COMMAND_PARK;
	//No new command
	else return c;
}

void displaycommand(unsigned char c) {
	if(c == COMMAND_FOLLOW0) display7segs('1', '0');
	else if(c == COMMAND_FOLLOW1) display7segs('2', '0');
	else if(c == COMMAND_FOLLOW2) display7segs('3', '0');
	else if(c == COMMAND_FOLLOW3) display7segs('4', '0');
	else if(c == COMMAND_PARK) display7segs('p', '?');
}