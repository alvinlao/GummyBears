;------------------------------------------------
; test_sensor.asm
;------------------------------------------------
; Tester for temperature/sensor.asm
;------------------------------------------------

$MODDE2

org 0000H
	ljmp MyProgram

DSEG at 30H
	;util/math16.asm	
	output:					DS 1
	x:						DS 2
	y:						DS 2
	bcd:					DS 3
	
	ovenVoltage:			DS 2
	coldVoltage:			DS 2
	currentTemp:			DS 1
	
BSEG
	mf:						DBIT 1
			
CSEG

;Dependencies
;$include(../util/helper.asm)
$include(../util/spi.asm)
$include(../util/math16.asm)

$include(../temperature/lm335.asm)
$include(../temperature/lookup.asm)
$include(../temperature/sensor.asm)

;For a 33.33MHz one clock cycle  takes 30ns
Wait:
	mov R2, #45
L3: mov R1, #250
L2: mov R0, #250
L1: djnz R0, L1 ; 3 machine cycles-> 3*30ns*250=22.5us
	djnz R1, L2 ; 22.5us*250=5.625ms
	djnz R2, L3 ; 5.625ms*90=0.5s (approximately)
	ret
	
MyProgram:
	mov sp, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0
	lcall setup_spi

testLoop:
	lcall getOvenTemp_sensor
	
	mov LEDG, R0
	
	lcall Wait
	
	sjmp testLoop
