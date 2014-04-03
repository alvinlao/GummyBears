#ifndef _INDUCTOR_H_
#define _INDUCTOR_H_

//Receiver inductor output with no B field (ADC output)
#define INDUCTOR_LEFT_BGB 15
#define INDUCTOR_RIGHT_BGB 25

#define INDUCTOR_YAP_MIN 25

//ADC Channel
#define INDUCTOR_LEFT 3
#define INDUCTOR_RIGHT 1

//How accurate do we have to be for distance to beacon? (cm)
#define DERROR 2
#define ALIGNERROR 4

//f(x) = p1*x + p2
#define INDUCTOR_CALIBRATE_P1	-0.00001017
#define INDUCTOR_CALIBRATE_P2	0.001983
#define INDUCTOR_CALIBRATE_P3	-0.1404
#define INDUCTOR_CALIBRATE_P4	5.023
#define INDUCTOR_CALIBRATE_P5	-41.73

//f(x) = p1*x^3 + p2*x^2 + p3*x + p4
#define INDUCTOR_LEFT_P1 -0.000000525
#define INDUCTOR_LEFT_P2 0.000733
#define INDUCTOR_LEFT_P3 -0.3495
#define INDUCTOR_LEFT_P4 82.36

#define INDUCTOR_RIGHT_P1 -0.0000006087
#define INDUCTOR_RIGHT_P2 0.0008923
#define INDUCTOR_RIGHT_P3 -0.4406
#define INDUCTOR_RIGHT_P4 100.

#endif