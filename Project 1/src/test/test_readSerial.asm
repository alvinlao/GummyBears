;------------------------------------------------
; test_writeSerial.asm
;------------------------------------------------
; Tester for util/serial.asm
;------------------------------------------------


$MODDE2

org 0000H
	ljmp MyProgram
org 0023h
	ljmp ISR_serial
	
DSEG at 30H
	BCD:	DS 3
	
	;TIMERS
	reload0_timer:			DS 2	; [high] [low]
	reload1_timer:			DS 2	; [high] [low]

	count1_100_timer:		DS 1	; Used for 1s calls

CSEG

;Dependencies
$include(../util/timer.asm)
$include(../util/helper.asm)
$include(../util/serial.asm)

ISR_serial:
	cpl LEDG.0
	JNB RI,ISR_finish_serial	;If the RI flag is not set, we jump to check TI
	MOV A, SBUF					;If we got to this line, its because the RI bit *was* set
	mov LEDRA, A
	CLR RI
ISR_finish_serial:
	reti
	
MyProgram:
	mov SP, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0

	;Setup
	lcall setup_read_serial
	setb EA
	
testLoop:
	sjmp $
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	
	sjmp testLoop
