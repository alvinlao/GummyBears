;------------------------------------------------
; timer.asm
;------------------------------------------------
; Timer operations
;------------------------------------------------
; REQURIES:
;		timer0_reload: DS 2
;		timer1_reload: DS 2
;------------------------------------------------
; Author: Alvin Lao
;------------------------------------------------

CLK EQU 33333333
FREQ_0 EQU 2000
FREQ_1 EQU 100
TIMER0_RELOAD EQU 65536-(CLK/(12*2*FREQ_0))
TIMER1_RELOAD EQU 65536-(CLK/(12*2*FREQ_1))

$NOLIST
CSEG

;------------------------------------------------    
; # Protected function
;------------------------------------------------
; ISR_timer0 (interrupt every 1s)
;------------------------------------------------
ISR_timer0:
	push psw
	push acc
	push dpl
	push dph

	mov TH0, timer0_reload
	mov TL0, timer0_reload+1

	; DO STUFF

	pop dph
	pop dpl
	pop acc
	pop psw

	reti


;------------------------------------------------    
; # Protected function
;------------------------------------------------
; ISR_timer1
; Interrupt for buzzer
;------------------------------------------------
ISR_timer1_buzzer:
	push psw
	push acc
	push dpl
	push dph

	mov TH1, timer1_reload
	mov TL1, timer1_reload+1

	; DO STUFF

	pop dph
	pop dpl
	pop acc
	pop psw

	reti

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup0_timer ( void )
; Setup timer 0
;------------------------------------------------
setup0_timer:
	mov TMOD, #00000001B	;GATE = 0, C/T*=0, M1=0, M0=1: 16-bit timer
	clr TR0			;Disable timer0
	clr TF0
	mov TH0, reload0_timer
	mov TL0, reload0_timer+1
	setb TR0		;Enable timer 0	
	setb ET0		;Enable timer 0 interrupt
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup1_timer ( void )
; Setup timer 1
;------------------------------------------------
setup1_timer:
	mov TMOD, #00000001B	;GATE = 0, C/T*=0, M1=0, M0=1: 16-bit timer
	clr TR1			;Disable timer1
	clr TF1
	mov TH1, reload1_timer
	mov TL1, reload1_timer+1
	setb TR1		;Enable timer 1
	setb ET1		;Enable timer 1 interrupt
	ret
$LIST
