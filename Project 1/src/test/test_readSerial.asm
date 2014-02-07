;------------------------------------------------
; test_writeSerial.asm
;------------------------------------------------
; Tester for util/serial.asm
;------------------------------------------------


$MODDE2

org 0000H
	ljmp MyProgram

org 0023H
	ljmp ISR_serial
	
DSEG at 30H
	BCD:	DS 3
	
	;TIMERS
	reload0_timer:			DS 2	; [high] [low]
	reload1_timer:			DS 2	; [high] [low]

	count1_100_timer:		DS 1	; Used for 1s calls
	
	myvars:					DS 7
 	setupFinish:			DS 1
 	setupPointer:			DS 1
 	
CSEG

;Dependencies
$include(../util/timer.asm)
$include(../util/helper.asm)
$include(../util/serial.asm)

ISR_serial:
	cpl LEDG.0
	mov LEDRA, setupPointer
	mov LEDRB, #setupFinish
	mov R0, setupPointer
	mov @R0, SBUF
	inc setupPointer
	clr RI
	reti


ext_setup:
	;If setupPointer == #setupFinish
	mov A, setupPointer
	cjne A, setupFinish, ext_setup
	ret
	
MyProgram:
	mov SP, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0

	;Setup
	mov setupPointer, #myvars
	mov setupFinish, #setupFinish
	lcall setup_read_serial		;Use external setup variables
	setb EA
	lcall ext_setup
	clr EA
	
testLoop:
	mov LEDRA, myvars
	
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	
	mov LEDRA, myvars+1
	
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	
	mov LEDRA, myvars+2
	
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	
	mov LEDRA, myvars+3
	
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	
	mov LEDRA, myvars+4
	
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	
	mov LEDRA, myvars+5
	
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	
	mov LEDRA, myvars+6
	
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	
	sjmp testLoop
