;------------------------------------------------
; test_driver.asm
;------------------------------------------------
; Tester for driver.asm
;------------------------------------------------

$MODDE2

RATE EQU 3

org 0000H
	ljmp MyProgram

DSEG at 30H
	prevTemp:	DS 1
	curTemp:	DS 1

MyProgram:
	mov sp, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0


	mov prevTemp, #22
	mov curTemp, #22
	lcall setup_driver

testLoop:
	mov R0, prevTemp
	mov R1, curTemp
	mov R2, #RATE
	lcall setRamp_driver	

	mov prevTemp, curTemp 
	inc curTemp
	inc curTemp
	inc curTemp

	sjmp testLoop
