;------------------------------------------------
; test_buzzer.asm
;------------------------------------------------
; Tester for util/buzzer.asm
;------------------------------------------------

$MODDE2

org 0000H
	ljmp MyProgram

DSEG at 30H
	prevTemp:	DS 1
	curTemp:	DS 1

CSEG
;Dependencies
MyProgram:
	mov sp, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0

	;Setup
	lcall setup1_timer
	lcall setup_buzzer
	
testLoop:
	lcall short_beep
	lcall wait_helper
	lcall wait_helper
	lcall wait_helper
	lcall wait_helper
	lcall wait_helper
	sjmp testLoop
