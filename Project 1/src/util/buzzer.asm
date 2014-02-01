;------------------------------------------------
; buzzer.asm
;------------------------------------------------
; Provides buzzer functionality
;------------------------------------------------
; DEPENDENCIES:
; 	helper.asm
;	timer.asm
; NOTE: 
;	Requires timer 1
;------------------------------------------------
; Author: Zhenzheng Xia
;------------------------------------------------

$NOLIST
CSEG
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup_buzzer( void )
; Setup buzzer frequency and output port
;------------------------------------------------
; MODIFIES:
;	reload1_timer
;------------------------------------------------
setup_buzzer:
	mov A, #00000010B
	orl A, P1MOD
	mov P1MOD, A

	mov reload1_timer, #high(TIMER1_RELOAD)
	mov reload1_timer+1, #low(TIMER1_RELOAD)
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void shortBeep_buzzer( void )
; Makes a short beep
;------------------------------------------------
shortBeep_buzzer:
	lcall start1_timer
	lcall Wait_helper
	lcall stop1_timer
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void longBeep_buzzer( void )
; Makes a long beep
;------------------------------------------------
longBeep_buzzer:
	lcall start1_timer
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall stop1_timer
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void sixBeeps_buzzer( void )
; Makes six beeps
;------------------------------------------------
sixBeeps_buzzer:
	MOV R3, #6
L0_buzzer:
	setb tr1
	lcall WAIT_HALF_SEC
	clr TR1
	lcall WAIT_HALF_SEC
	DJNZ R3, L0_buzzer
	ret

$LIST
