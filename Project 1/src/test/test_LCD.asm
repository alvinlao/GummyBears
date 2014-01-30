;------------------------------------------------
; strings.asm
;------------------------------------------------
; Strings
; Display strings on LCD
;------------------------------------------------

$MODDE2
org 0000H
	ljmp MyProgram

DSEG at 30H
	;util/LCD.asm
	string_LCD:			DS 32	
	
	;util/math16.asm	
	output:				DS 1
	x:					DS 2
	y:					DS 2
	bcd:				DS 3

CSEG
$include(../util/LCD.asm)
$include(../util/helper.asm)

hello:
	DB 'hello           ', '                '
	
myprogram:
	mov SP, #7FH
	mov LEDRA, #0
	mov LEDRB, #0
	mov LEDRC, #0
	mov LEDG, #0
	
	lcall setup_LCD

Loop:
	mov string_LCD, #'h'
	lcall displayString_LCD
	sjmp $
	