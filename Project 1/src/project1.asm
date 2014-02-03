;------------------------------------------------
;	PROJECT 1: Reflow Oven
;------------------------------------------------
;	GROUP: 		A5
;------------------------------------------------
;	MEMBERS:	Alvin Lao			
;				David Henderson		
;				Zhenzheng Xia		
;				Bibek Kaur			
;				Jappy Sran			
;				Haowei Yu
;------------------------------------------------

$MODDE2

org 0000H
   ljmp MyProgram

ORG 000BH
	ljmp ISR_timer0
	
ORG 001BH
	ljmp ISR_timer1

DSEG at 30H
	;TIMERS
	reload0_timer:			DS 2	; [high] [low]
	reload1_timer:			DS 2	; [high] [low]

	count1_100_timer:		DS 1	; Used for 1s calls
	
	;STATES
	currentTemp:			DS 1
	currentState:			DS 1	; 0 - IDLE, 1 - PREHEAT, 2 - SOAK, 3 - REFLOWRAMP, 4 - REFLOW, 5 - COOL, 6 - FINISH
	currentStateTime:		DS 2
	runTime:				DS 2 	; [seconds | minutes]

	soakRate: 				DS 1
 	soakTemp: 				DS 1
 	soakTime:				DS 1
 	reflowRate:				DS 1
 	reflowTemp:				DS 1
 	reflowTime:				DS 1
 	coolRate:				DS 1
	finishTemp:				DS 1
 	
	;temperature/sensor.asm
	ovenVoltage:			DS 2
	coldVoltage:			DS 2
		
	;util/LCD.asm
	string_LCD:				DS 32	
	
	;util/math16.asm	
	output:					DS 1
	x:						DS 2
	y:						DS 2
	bcd:					DS 3
	
	;compare for cjne instruction
	compare:				DS 1
	
BSEG
	mf:						DBIT 1

;-------------------------------------
; Utility
;-------------------------------------
$include(util/helper.asm)
$include(util/timer.asm)
$include(util/spi.asm)
$include(util/serial.asm)
$include(util/buzzer.asm)
$include(util/LCD.asm)
$include(util/math16.asm)

;-------------------------------------
; Values
;-------------------------------------
$include(values/constants.asm)		;Constants
$include(values/strings.asm)		;Strings (for LCD)

;-------------------------------------
; States
;-------------------------------------
$include(setup.asm)					;Initial user configuration
$include(live.asm)					;Initial user configuration
$include(finish.asm)				;Final exit instructions

;-------------------------------------
; Oven
;-------------------------------------
$include(oven/driver.asm)			;Oven driver
$include(oven/controller.asm)		;Oven controller

;-------------------------------------
; Temperature
;-------------------------------------
$include(temperature/lm335.asm)		;LM335 voltage to temperature conversion
$include(temperature/lookup.asm)	;Lookup table and functions
$include(temperature/sensor.asm)	;Handle oven temperature

CSEG

;------------------------------------------------    
; # Protected function
;------------------------------------------------
; ISR_timer0
; Interrupt for buzzer
;------------------------------------------------
ISR_timer0:
	mov TH0, reload0_timer
	mov TL0, reload0_timer+1

	; DO STUFF
	cpl P1.1
	reti


;------------------------------------------------    
; # Protected function
;------------------------------------------------
; ISR_timer1 100 Hz
;------------------------------------------------
; USERS:
;	oven/controller.asm - Call every 1s
;------------------------------------------------
ISR_timer1:
	push psw
	push acc
	push dpl
	push dph
	
	clr RS0
	setb RS1
	
	mov TH1, reload1_timer
	mov TL1, reload1_timer+1
	
	djnz count1_100_timer, continue1_timer
	mov count1_100_timer, #100	
	
	; DO STUFF EVERY 1s
	
	;Update run time
	mov A, runTime
	add A, #1
	mov runTime, A
	mov A, runTime+1
	addc A, #0
	mov runTime+1, A

	;Update current state run tim
	mov A, currentStateTime
	add A, #1
	mov currentStateTime, A
	mov A, currentStateTime+1
	addc A, #0
	mov currentStateTime+1, A

	;Get oven temperature
	lcall getOvenTemp_sensor
	
	;Update target oven temperature	
	lcall update_controller

	cpl LEDG.0	
	
continue1_timer:
	; DO STUFF EVERY 0.1s
	
	pop dph
	pop dpl
	pop acc
	pop psw
	reti
;-------------------------------------
;MAIN PROGRAM
;-------------------------------------
myprogram:
	;Setup Board
    MOV SP, #7FH
    mov LEDRA, #0
    mov LEDRB, #0
    mov LEDRC, #0
    mov LEDG, #0
	orl P0MOD, #00111000b 		; make all CEs outputs

	;Setup Modules
	lcall setup_spi			; ADC SPI (Input)
	lcall setup_serial 		; Serial (Output)
	lcall setup_lcd			; Setup LCD
	lcall setup_driver		; P1 output pins
	lcall setup_buzzer		; Buzzer sets up timer1 reload value
	
	;Setup global variables	
	mov currentState, #0
	mov runTime, #0
	mov currentStateTime, #0

	;Go to setup.asm (User input loop)
	lcall go_setup

	;Setup and start timers
	lcall setup0_timer
	lcall setup1_timer
	
	lcall start1_timer
	
	setb EA							; Enable interrupts
	mov LEDRA, #0H
	
	lcall shortBeep_buzzer
mainLoop:
	;Check if temp > 250
	;Check stop switch
	mov A, SWC
	anl A, #00000010B
	jz forceStop

	;Check if finish state
	clr c
	mov A, currentState
	subb A, #6
	jz finish

	;Update board displays
	lcall update_live

	;Send current temperature to computer
	mov R0, currentTemp
	;mov LEDRB, currentTemp
	lcall sendByte_serial
	mov R0, #'\n'
	lcall sendByte_serial

	lcall Wait_helper				; Wait 0.25s
	sjmp mainLoop

forceStop:
	setb LEDRA.0
	lcall stop0_timer
	lcall force_finish
	sjmp $

finish:
	setb LEDRA.1
	lcall stop0_timer
	lcall go_finish
	sjmp $
