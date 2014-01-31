;------------------------------------------------
; strings.asm
;------------------------------------------------
; Strings
; Display strings on LCD
;------------------------------------------------

$MODDE2
org 0000H
	ljmp MyProgram

DSEG at 30H
	;STATES
	currentTemp:		DS 1
	currentState:		DS 1	; IDLE, SOAKRAMP, SOAK, REFLOWRAMP, REFLOW, COOL
	runTime:			DS 2

	soakRate: 			DS 1
 	soakTemp: 			DS 1
 	soakTime:			DS 1
 	reflowRate:			DS 1
 	reflowTemp:			DS 1
 	reflowTime:			DS 1
 	coolRate:			DS 1
 	
	;temperature/sensor.asm
	ovenVoltage:		DS 2
	coldVoltage:		DS 2
		
	;util/LCD.asm
	string_LCD:			DS 32	
	
	;util/math16.asm	
	output:				DS 1
	x:					DS 2
	y:					DS 2
	bcd:				DS 3
	
	;compare for cjne instruction
	compare:			DS 1
	
BSEG
	mf:					DBIT 1

CSEG
$include(../util/LCD.asm)
$include(../util/math16.asm)
$include(../values/constants.asm)
$include(../values/strings.asm)
$include(../util/helper.asm)
$include(../setup.asm)

	
myprogram:
	mov SP, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0
	LCALL setup_LCD
	LCALL go_setup

Loop:
	SETB LEDRA.0
	sjmp $
	