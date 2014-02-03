;------------------------------------------------
; buzzer.asm
;------------------------------------------------
; Provides buzzer functionality
;------------------------------------------------
; DEPENDENCIES:
; 	helper.asm
;	timer.asm
; NOTE: 
;	Requires timer 0
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
	;Setup buzzer output port P1.1
	mov A, #00000010B
	orl A, P1MOD
	mov P1MOD, A

	mov reload0_timer, #high(TIMER0_RELOAD)
	mov reload0_timer+1, #low(TIMER0_RELOAD)
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void shortBeep_buzzer( void )
; Makes a short beep
;------------------------------------------------
shortBeep_buzzer:
	lcall start0_timer
	mov buzzer_small , #250
	mov buzzer_big , #3
	mov buzzer_temp , buzzer_small
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void longBeep_buzzer( void )
; Makes a long beep
;------------------------------------------------
longBeep_buzzer:
	lcall start0_timer
	mov buzzer_small , #250
	mov buzzer_big , # 15
	mov buzzer_temp , buzzer_small
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void sixBeeps_buzzer( void )
; Makes six beeps
;------------------------------------------------
sixBeeps_buzzer:
	lcall shortBeep_buzzer
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall shortBeep_buzzer
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall shortBeep_buzzer
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall shortBeep_buzzer
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall shortBeep_buzzer
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall shortBeep_buzzer
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
	lcall Wait_helper
$LIST
