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

ORG 001BH
	ljmp ISR_timer0
	
ORG 001BH
	ljmp ISR_timer1

DSEG at 30H
	;TIMERS
	reload0_timer:			DS 1
	reload1_timer:			DS 1
	
	;STATES
	currentTemp:			DS 1
	currentState:			DS 1	; 0 - IDLE, 1 - PREHEAT, 2 - SOAK, 3 - REFLOWRAMP, 4 - REFLOW, 5 - COOL
	currentStateTime:		DS 1
	runTime:				DS 2 	; [seconds | minutes]

	soakRate: 				DS 1
 	soakTemp: 				DS 1
 	soakTime:				DS 1
 	reflowRate:				DS 1
 	reflowTemp:				DS 1
 	reflowTime:				DS 1
 	coolRate:				DS 1
 	`
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
$include(util/spi.asm)
$include(util/serial.asm)
$include(util/buzzer.asm)
$include(util/LCD.asm)
$include(util/math16.asm)

$include(values/constants.asm)		;Constants

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
;$include(oven/controller.asm)		;Oven controller

;-------------------------------------
; Temperature
;-------------------------------------
$include(temperature/lm335.asm)		;LM335 voltage to temperature conversion
$include(temperature/lookup.asm)	;Lookup table and functions
$include(temperature/sensor.asm)	;Handle oven temperature

CSEG

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
	lcall setup0_timer		; setup timer0
	lcall setup1_timer		; setup timer1	
	lcall setup_spi			; ADC SPI (Input)
	lcall setup_serial 		; Serial (Output)
	lcall setup_lcd			; Setup LCD
	lcall setup_driver		; P1 output pins
	
	;Setup global variables	
	mov currentState, #0
	mov runTime, #0
	mov currentStateTime, #0

	;Call setup.asm
	lcall go_setup

	;Setup and start timers
	lcall setup0_timer
	lcall setup1_timer

	lcall start0_timer
	lcall start1_timer

mainLoop:
	lcall getOvenTemp_sensor	; R0 <= oven temperature
	mov LEDRA, R0
	
	mov x, R0
	mov x+1, #0
	lcall hex2bcd
	lcall displayBCD_helper		; Display the temp on 7 seg
	
	;lcall logTemperature 		; void logTemperature(temp [R0])

	lcall Wait_helper
	sjmp mainLoop
