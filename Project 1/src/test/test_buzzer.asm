;------------------------------------------------
; test_buzzer.asm
;------------------------------------------------
; Tester for util/buzzer.asm
;------------------------------------------------

$MODDE2

org 0000H
	ljmp MyProgram
ORG 001BH
	ljmp ISR_timer1
DSEG at 30H
	;TIMERS
	reload0_timer:			DS 2	; [high] [low]
	reload1_timer:			DS 2	; [high] [low]

	count0_100_timer:		DS 1	; Used for 1s calls

	;util/math16.asm	
	output:					DS 1
	x:						DS 2
	y:						DS 2
	bcd:					DS 3
	
CSEG

;Dependencies
$include(../util/helper.asm)
$include(../util/timer.asm)
$include(../util/buzzer.asm)

;------------------------------------------------    
; # Protected function
;------------------------------------------------
; ISR_timer1
; Interrupt for buzzer
;------------------------------------------------
ISR_timer1:
	push psw
	push acc
	push dpl
	push dph

	mov TH1, reload1_timer
	mov TL1, reload1_timer+1
	cpl P1.1
	
	; DO STUFF

	pop dph
	pop dpl
	pop acc
	pop psw

	reti
	
MyProgram:
	mov sp, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0

	;Setup
	lcall setup_buzzer
	lcall setup1_timer
		
	mov reload1_timer, #high(TIMER1_RELOAD)
	mov reload1_timer+1, #low(TIMER1_RELOAD)
	lcall start1_timer
	setb EA
testLoop:
	lcall shortBeep_buzzer
	lcall wait_helper
	lcall wait_helper
	lcall wait_helper
	lcall wait_helper
	lcall wait_helper
	cpl LEDRA.0
	
	sjmp testLoop
