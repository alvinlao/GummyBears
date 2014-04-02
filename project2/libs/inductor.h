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

//f(x) = p1*x + p2
#define INDUCTOR_CALIBRATE_P1	-0.000004501
#define INDUCTOR_CALIBRATE_P2	0.000807
#define INDUCTOR_CALIBRATE_P3	-0.05082
#define INDUCTOR_CALIBRATE_P4	2.263
#define INDUCTOR_CALIBRATE_P5	-12.44

//f(x) = p1*x^3 + p2*x^2 + p3*x + p4
#define INDUCTOR_LEFT_P1 -0.0000005369
#define INDUCTOR_LEFT_P2 0.0007855
#define INDUCTOR_LEFT_P3 -0.3992
#define INDUCTOR_LEFT_P4 94.13

#define INDUCTOR_RIGHT_P1 -0.0000005153
#define INDUCTOR_RIGHT_P2 0.0007715
#define INDUCTOR_RIGHT_P3 -0.4032
#define INDUCTOR_RIGHT_P4 98.55

#endif