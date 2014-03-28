#include <stdio.h>
#include <at89lp51rd2.h>

#include "../libs/util.h"
#include "remote.h"

char isFollow(unsigned char c) {
	if(c == 101 ||
		c == 102 ||
		c == 103 ||
		c == 104
	) return 1;
	
	else return 0;
}

unsigned char nextFollowCommand(unsigned char c) {
	if(c == 101) return 102;
	else if(c == 102) return 103;
	else if(c == 103) return 104;
	else if(c == 104) return 101;
	else return 101;
}

unsigned char getNextCommand(unsigned char currentCommand) {
	//Change follow distance
	if(P0_0 == 1 && isFollow(currentCommand) == 1) {
		return nextFollowCommand(currentCommand);
	}
	//Follow
	else if(P0_2 == 1) return 101;
	//180
	else if(P0_4 == 1) return 180;
	else if(P0_6 == 1) return 204;
	else return 101;
}

void displaycommand(unsigned char c) {
	if(c == 101) display7segs('1', '0');
	else if(c == 102) display7segs('2', '0');
	else if(c == 103) display7segs('3', '0');
	else if(c == 104) display7segs('4', '0');
	else if(c == 204) display7segs('p', '?');
}