;------------------------------------------------
; buzzer.asm
;------------------------------------------------
; Provides buzzer functionality
;------------------------------------------------
; NOTE: 
;	Requires timer 1
;------------------------------------------------
; Author: Zhenzheng Xia
;------------------------------------------------

$NOLIST

CSEG
WAIT_HALF_SEC:
	mov R2, #89
L3_buzzer: mov R1, #250
L2_buzzer: mov R0, #250
L1_buzzer: djnz R0, L1_buzzer
	djnz R1, L2_buzzer
	djnz R2, L3_buzzer
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup_buzzer( void )
; Setup timer 1 (!) for subsequent buzzer functions
;------------------------------------------------
setup_buzzer:
   	mov P0MOD, #00000011B ; P0.0, P0.1 are outputs.
   	setb P0.0

	mov TMOD,  #00010001B ; GATE=0, C/T*=0, M1=0, M0=1: 16-bit timer
	clr TR1 ; Disable timer 0
	clr TF1
	mov TH1, #high(TIMER1_RELOAD)
	mov TL1, #low(TIMER1_RELOAD)
	;setb TR1 ; Enable timer 0
    	setb ET1 ; Enable timer 0 interrupt
	setb EA  ; Enable all interrupts
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void shortBeep_buzzer( void )
; Makes a short beep
;------------------------------------------------
shortBeep_buzzer:
	setb tr1
	lcall WAIT_HALF_SEC
	clr TR1
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void longBeep_buzzer( void )
; Makes a long beep
;------------------------------------------------
longBeep_buzzer:
	setb tr1
	lcall WAIT_HALF_SEC
	lcall WAIT_HALF_SEC
	lcall WAIT_HALF_SEC
	clr TR1
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
