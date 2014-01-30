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

$NOLIST
CSEG

;------------------------------------------------    
; # Protected function
;------------------------------------------------
; ISR_timer0
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
; ISR_timer1_buzzer
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
	
$LIST
