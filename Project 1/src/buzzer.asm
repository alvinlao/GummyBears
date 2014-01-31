; Blinky_Int.asm: blinks LEDR0 of the DE2-8052 each second.
; Also generates a 2kHz signal at P0.0 using timer 0 interrupt.
; Also keeps a BCD counter using timer 2 interrupt.

$MODDE2

CLK EQU 33333333
FREQ_1 EQU 500
TIMER1_RELOAD EQU 65536-(CLK/(12*FREQ_1))

org 0000H
	ljmp myprogram
	
org 001BH
	ljmp ISR_timer1

WAIT_HALF_SEC:
	mov R2, #89
L3: mov R1, #250
L2: mov R0, #250
L1: djnz R0, L1
	djnz R1, L2
	djnz R2, L3
	ret
	
ISR_timer1:
	push psw
	push acc
	push dpl
	push dph
	
	cpl P0.1
	mov TH1, #high(TIMER1_RELOAD)
    mov TL1, #low(TIMER1_RELOAD)
	
	pop dph
	pop dpl
	pop acc
	pop psw
	
	reti

shortBeep_buzzer:
	setb tr1
	lcall WAIT_HALF_SEC
	clr TR1
	SJMP LL

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
myprogram:
	mov SP, #7FH
	mov LEDRA,#0
	mov LEDRB,#0
	mov LEDRC,#0
	mov LEDG,#0
	
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
    
M0:
	jb swa.0, shortBeep_buzzer
	jb swa.1, longBeep_buzzer
	jb swa.2, sixBeeps_buzzer

	sjmp M0
END
