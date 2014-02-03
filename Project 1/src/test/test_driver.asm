;------------------------------------------------
; test_driver.asm
;------------------------------------------------
; Tester for driver.asm
;------------------------------------------------

$MODDE2

RATE EQU 3

org 0000H
	ljmp MyProgram

ORG 001BH
	ljmp ISR_timer1
	
DSEG at 30H	
	;TIMERS
	reload0_timer:			DS 2	; [high] [low]
	reload1_timer:			DS 2	; [high] [low]

	count1_100_timer:		DS 1	; Used for 1s calls
	
	;STATES
	prevTemp:				DS 1
	currentTemp:			DS 1
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
	
BSEG
	mf:						DBIT 1

;-------------------------------------
; Utility
;-------------------------------------
$include(../util/helper.asm)
$include(../util/timer.asm)
$include(../util/spi.asm)
$include(../util/serial.asm)
$include(../util/buzzer.asm)
$include(../util/LCD.asm)
$include(../util/math16.asm)

;-------------------------------------
; Values
;-------------------------------------
$include(../values/constants.asm)		;Constants
$include(../values/strings.asm)		;Strings (for LCD)
$include(../live.asm)					;Initial user configuration

;-------------------------------------
; Oven
;-------------------------------------
$include(../oven/driver.asm)			;Oven driver

;-------------------------------------
; Temperature
;-------------------------------------
$include(../temperature/lm335.asm)		;LM335 voltage to temperature conversion
$include(../temperature/lookup.asm)	;Lookup table and functions
$include(../temperature/sensor.asm)	;Handle oven temperature


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
mov LEDG, prevTemp
	mov LEDRB, currentTemp
	lcall update_live
	
continue1_timer:
	; DO STUFF EVERY 0.1s
	
	pop dph
	pop dpl
	pop acc
	pop psw
	reti
	
	
MyProgram:
	mov sp, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0
	
	mov soakRate, #2
	lcall setup_spi			; ADC SPI (Input)
	lcall setup_driver		; P1 output pins
	
	;Setup global variables	
	mov prevTemp, #0
	mov currentTemp, #0	
	mov currentState, #0
	mov runTime, #0
	mov runTime+1, #0
	mov currentStateTime, #0
		
	;Setup and start timers
	lcall setup0_timer
	lcall setup1_timer
	
	lcall start1_timer	
	setb EA
testLoop:
	mov R0, currentTemp
	mov R1, #150
	lcall maintainTemp_driver
	lcall wait_helper
	lcall wait_helper
	lcall wait_helper
	sjmp testLoop
