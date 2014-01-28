;------------------------------------------------
; buzzer.asm
;------------------------------------------------
; Provides buzzer functionality
;------------------------------------------------
; NOTE: 
;	Requires timer 1
;------------------------------------------------
; Author: 
;------------------------------------------------

$NOLIST

DSEG
	timer1_reload_buzzer:	DS 2
	
CSEG

;------------------------------------------------    
; # Protected function
;------------------------------------------------
; ISR_timer0
;------------------------------------------------
ISR_timer1_buzzer:
	push psw
	push acc
	push dpl
	push dph

	mov TH1, timer1_reload_buzzer
	mov TL1, timer1_reload_buzzer+1
	
	; DO STUFF
	
	pop dph
	pop dpl
	pop acc
	pop psw
	
	reti
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup_buzzer( void )
; Setup timer 1 (!) for subsequent buzzer functions
;------------------------------------------------
setup_buzzer:
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void shortBeep_buzzer( void )
; Makes a short beep
;------------------------------------------------
shortBeep_buzzer:
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void longBeep_buzzer( void )
; Makes a long beep
;------------------------------------------------
longBeep_buzzer:
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void sixBeeps_buzzer( void )
; Makes six beeps
;------------------------------------------------
sixBeeps_buzzer:
	ret

$LIST