;------------------------------------------------
; test_serial.asm
;------------------------------------------------
; Tester for util/serial.asm
;------------------------------------------------

$MODDE2

org 0000H
	ljmp MyProgram

DSEG at 30H
	BCD:	DS 3
	reload0_timer: DS 2
	reload1_timer: DS 2	
CSEG

;Dependencies
$include(../util/timer.asm)
$include(../util/helper.asm)
$include(../util/serial.asm)
	
MyProgram:
	mov sp, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0

	;Setup
	lcall setup_serial
	
	setb EA
testLoop:
	mov R0, #high(250)
	lcall sendByte_serial
	
	mov R0, #low(250)
	lcall sendByte_serial
	
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	
	sjmp testLoop
