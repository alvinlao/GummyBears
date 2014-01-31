; Blinky_Int.asm: blinks LEDR0 of the DE2-8052 each second.
; Also generates a 2kHz signal at P0.0 using timer 0 interrupt.
; Also keeps a BCD counter using timer 2 interrupt.

$NOLIST

DSEG at 30H
timer:

WAIT_HALF_SEC:
	mov R2, #89
L3: mov R1, #250
L2: mov R0, #250
L1: djnz R0, L1
	djnz R1, L2
	djnz R2, L3
	ret


shortBeep_buzzer:
	setb tr1
	lcall WAIT_HALF_SEC
	clr TR1
ret

longBeep_buzzer:
	setb tr1
	lcall WAIT_HALF_SEC
	lcall WAIT_HALF_SEC
	lcall WAIT_HALF_SEC
	clr TR1
	SJMP LL
	
sixBeeps_buzzer:
	MOV R3, #6
L0:
	setb tr1
	lcall WAIT_HALF_SEC
	clr TR1
	lcall WAIT_HALF_SEC
	DJNZ R3, L0
	SJMP LL
LL:
	jb swa.0, LL
	jb swa.1, LL
	jb swa.2, LL
	sjmp m0

	
setup_buzzer:

    mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
    
M0:
	jb swa.0, shortBeep_buzzer
	jb swa.1, longBeep_buzzer
	jb swa.2, sixBeeps_buzzer

ret


$LIST
