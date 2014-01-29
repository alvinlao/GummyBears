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
	ljmp ISR_timer1_buzzer

DSEG at 30H
	;temperature/sensor.asm
	ovenVoltage:		DS 2
	coldVoltage:		DS 2

	;LCD.asm
	line1_LCD:			DS 16
	line2_LCD:			DS 16		; (!) These two must be right after each other
		
	;VARIABLES
	currentTemp:		DS 1
	currentState:		DS 1	; IDLE, SOAKRAMP, SOAK, REFLOWRAMP, REFLOW, COOL
	runTime:			DS 2

	;Setup.asm
	soakRate: 			DS 1
 	soakTemp: 			DS 1
 	soakTime:			DS 1
 	reflowRate:			DS 1
 	reflowTemp:			DS 1
 	reflowTime:			DS 1
 	coolRate:			DS 1
	
	;MATH16.asm	
	output:				DS 1
	x:					DS 2
	y:					DS 2
	bcd:				DS 3
	
BSEG
	mf:					DBIT 1

;-------------------------------------
; Utility
;-------------------------------------
$include(util/helper.asm)
$include(util/spi.asm)
$include(util/serial.asm)
$include(util/buzzer.asm)
$include(util/LCD.asm)
$include(util/math16.asm)

$include(values/constants.asm)	;Constants

;-------------------------------------
; States
;-------------------------------------
$include(setup.asm)				;Initial user configuration
$include(live.asm)				;Initial user configuration
$include(finish.asm)			;Final exit instructions

;-------------------------------------
; Oven
;-------------------------------------
;$include(oven/driver.asm)		;Oven driver
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
    MOV SP, #7FH
    mov LEDRA, #0
    mov LEDRB, #0
    mov LEDRC, #0
    mov LEDG, #0
	orl P0MOD, #00111000b 		; make all CEs outputs
	
	lcall setup_spi				; ADC SPI (Input)
    lcall setup_serial 			; Serial (Output)
    	
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
