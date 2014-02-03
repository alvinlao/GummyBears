;------------------------------------------------
; test_buzzer.asm
;------------------------------------------------
; Tester for util/buzzer.asm
;------------------------------------------------

$MODDE2

org 0000H
	ljmp MyProgram
ORG 000BH
	ljmp ISR_timer0
DSEG at 30H
	;TIMERS
	reload0_timer:			DS 2	; [high] [low]
	reload1_timer:			DS 2
	count1_100_timer:       DS 1
	buzzer_small:           DS 1	; [high] [low]
	buzzer_big:				DS 1
	buzzer_temp:			DS 1
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
; ISR_timer0
; Interrupt for buzzer
;------------------------------------------------
ISR_timer0:
	cpl P1.1
	mov TH0, reload0_timer
	mov TL0, reload0_timer+1
	djnz buzzer_small , skip_buzzer ; decrements the first one 
	mov buzzer_small , buzzer_temp	; resets the first one
	djnz buzzer_big , skip_buzzer ; decrements the second onemov buzzer_big , buzzer_tempLoop ; resets the second one
	lcall stop0_timer
skip_buzzer:
	reti
	
MyProgram:
	mov sp, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0

	;Setup
	lcall setup_buzzer
	lcall setup0_timer

	setb EA
testLoop:
	lcall shortBeep_buzzer
	cpl LEDRA.0
	
	sjmp $
