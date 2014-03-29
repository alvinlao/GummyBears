#ifndef _UTIL_H_
#define _UTIL_H_

//7 seg ports
#define SEG_A P2
#define SEG_B P3

unsigned int getADC(unsigned char channel);
void display7segs(char a, char b);

#endif