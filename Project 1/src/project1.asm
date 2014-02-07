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
	
ORG 0023H
	ljmp ISR_serial
	
	
DSEG at 30H
	;TIMERS
	reload0_timer:			DS 2	; [high] [low]
	reload1_timer:			DS 2	; [high] [low]

	count1_100_timer:		DS 1	; Used for 1s calls
	
	;STATES
	prevTemp:				DS 1	; *C
	currentTemp:			DS 1	; *C
	currentState:			DS 1	; 0 - IDLE, 1 - PREHEAT, 2 - SOAK, 3 - REFLOWRAMP, 4 - REFLOW, 5 - COOL, 6 - FINISH
	currentStateTime:		DS 1	; seconds
	runTime:				DS 2 	; [seconds | minutes]

	soakRate: 				DS 1
 	soakTemp: 				DS 1
 	soakTime:				DS 1
 	reflowRate:				DS 1
 	reflowTemp:				DS 1
 	reflowTime:				DS 1
 	coolRate:				DS 1
 	setupFinish:			DS 1
 	setupPointer:			DS 1
 	
 	;buzzer 
 	buzzer_small:           DS 1	; [high] [low]
	buzzer_big:				DS 1
	buzzer_temp:			DS 1
 	
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
	cpl P1.1
	mov TH0, reload0_timer
	mov TL0, reload0_timer+1
	djnz buzzer_small , skip_buzzer ; decrements the first one 
	mov buzzer_small , buzzer_temp	; resets the first one
	djnz buzzer_big , skip_buzzer ; decrements the second onemov buzzer_big , buzzer_tempLoop ; resets the second one
	lcall stop0_timer
skip_buzzer:
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
	mov B, A
	subb A, #60
	jnz saveRunTime	; Normal inc
	mov B, #0
	inc runTime+1		
saveRunTime:
	mov runTime, B

	;Update current state run tim
	inc currentStateTime

	;Get oven temperature
	lcall getOvenTemp_sensor
	
	;Update target oven temperature	
	lcall update_controller

	;Update board displays
	lcall update_live

	;Send current temperature to computer
	mov R0, currentTemp
	;mov LEDRB, currentTemp
	lcall sendByte_serial
	mov R0, #'\n'
	lcall sendByte_serial
	
	cpl LEDG.0
	
continue1_timer:
	; DO STUFF EVERY 0.1s

finish1_timer:		
	pop dph
	pop dpl
	pop acc
	pop psw
	reti

;------------------------------------------------    
; # Protected function
;------------------------------------------------
; ISR_serial
;------------------------------------------------
; USERS:
;	setup.asm
;------------------------------------------------	
ISR_serial:
	mov R0, setupPointer
	mov @R0, SBUF
	inc setupPointer
	clr RI
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
	lcall setup_lcd			; Setup LCD
	lcall setup_driver		; P1 output pins
	lcall setup_buzzer		; Buzzer sets up timer1 reload value
	
	;Setup global variables	
	mov prevTemp, #0
	mov currentTemp, #0	
	mov currentState, #0
	mov runTime, #0
	mov runTime+1, #0
	mov currentStateTime, #0
	mov setupFinish, #0

	;If SWC.0 == 1, get setup variables from serial port
	;Else use on board switches and push buttons
	mov A, SWC
	anl A, #00000001B
	jz normalSetup
		lcall setup_read_serial		;Use external setup variables
		lcall ext_setup
		sjmp afterSetup
		
normalSetup:
	;Go to normal setup.asm (User input loop)
	lcall go_setup

afterSetup:	
	;Setup serial write
	lcall setup_write_serial 		; Serial (Output)
	
	;Setup and start timers
	lcall setup0_timer
	lcall setup1_timer
	
	lcall start1_timer
	
	setb EA							; Enable interrupts
	mov LEDRA, #0H
	lcall shortBeep_buzzer
	
mainLoop:
	;Check if temp > 250
	mov x, currentTemp
	mov x+1, #0
	mov y, #250
	mov y+1, #0
	lcall x_gt_y
	jb mf, hotStop
	
	;Check stop switch
	mov A, SWC
	anl A, #00000010B
	jz forceStop

	;Check if finish state
	clr c
	mov A, currentState
	subb A, #6
	jz finish

	lcall Wait_helper				; Wait 0.25s
	sjmp mainLoop
	
hotStop:
	lcall stop1_timer
	lcall hot_finish
	sjmp $
	
forceStop:
	lcall stop1_timer
	lcall force_finish
	sjmp $

finish:
	lcall stop1_timer
	lcall go_finish
	sjmp $
