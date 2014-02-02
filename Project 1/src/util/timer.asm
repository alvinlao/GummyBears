;------------------------------------------------
; timer.asm
;------------------------------------------------
; Timer operations
;------------------------------------------------
; REQURIES:
;		reload0_timer: DS 2
;		reload1_timer: DS 2
;------------------------------------------------
; Author: Alvin Lao
;------------------------------------------------


$NOLIST

CLK EQU 33333333
FREQ_0 EQU 2000
FREQ_1 EQU 3000
BAUD EQU 115200
TIMER0_RELOAD EQU 65536-(CLK/(12*2*FREQ_0))
TIMER1_RELOAD EQU 65536-(CLK/(12*FREQ_1))
TIMER2_RELOAD EQU 65536-(CLK/(32*BAUD))

CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup0_timer ( void )
; Setup timer 0
;------------------------------------------------
setup0_timer:
	mov A, #00000001B
	orl A, TMOD
	mov TMOD, A		;GATE = 0, C/T*=0, M1=0, M0=1: 16-bit timer	
	clr TR0			;Disable timer0
	clr TF0
	mov TH0, reload0_timer
	mov TL0, reload0_timer+1
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup1_timer ( void )
; Setup timer 1
;------------------------------------------------
setup1_timer:
	mov A, #00010000B
	orl A, TMOD
	mov TMOD, A		;GATE = 0, C/T*=0, M1=0, M0=1: 16-bit timer
	clr TF1
	mov TH1, reload1_timer
	mov TL1, reload1_timer+1
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void start0_timer ( void )
; Start timer0
;------------------------------------------------
start0_timer:
	setb TR0 		;Enable timer0
	setb ET0		;Enable timer0 interrupt
	mov count0_100_timer, #100
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void start1_timer ( void )
; Start timer1
;------------------------------------------------
start1_timer:
	setb TR1		;Enable timer1
	setb ET1		;Enable timer1 interrupt
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void stop0_timer ( void )
; Stop timer0
;------------------------------------------------
stop0_timer:
	clr TR0
	clr ET0
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void stop1_timer ( void )
; Stop timer1
;------------------------------------------------
stop1_timer:
	clr TR1
	clr ET1
	ret

$LIST
