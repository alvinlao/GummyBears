;------------------------------------------------
; helper.asm
;------------------------------------------------
; Useful functions
;------------------------------------------------
; Author: Alvin Lao
;------------------------------------------------

$NOLIST
CSEG
; Look-up table for 7-segment displays
sevenSegLUT:
    DB 0C0H, 0F9H, 0A4H, 0B0H, 099H
    DB 092H, 082H, 0F8H, 080H, 090H
    DB 03FH ;#0AH '-' 
    DB 0FFH ;#0BH OFF

;------------------------------------------------    
; + Public function
;------------------------------------------------    
; Wait 0.25 second
;------------------------------------------------
Wait_helper:
	mov R2, #45
L3: mov R1, #250
L2: mov R0, #250
L1: djnz R0, L1 ; 3 machine cycles-> 3*30ns*250=22.5us
	djnz R1, L2 ; 22.5us*250=5.625ms
	djnz R2, L3 ; 5.625ms*90=0.5s (approximately)
	ret

	
;------------------------------------------------    
; + Public function
;------------------------------------------------    
; Wait 40 microseconds
;------------------------------------------------
Wait40us_helper:
	mov R0, #149
X1_helper: 
	nop
	nop
	nop
	nop
	nop
	nop
	djnz R0, X1_helper ; 9 machine cycles-> 9*30ns*149=40us
    ret
	
	
;------------------------------------------------    
; + Public function
;------------------------------------------------    
; Returns a byte from code memory
;------------------------------------------------
; INPUT:
;	dptr - The memory address
;------------------------------------------------
; OUTPUT:
;	R0 - The byte at input memory address
;------------------------------------------------
getCodeByte_helper:
	clr A
	movc A, @A+dptr
	mov R0, A
	ret
	
	
;------------------------------------------------
; + Public function
;------------------------------------------------
; Display BCD - Displays BCD global var
;------------------------------------------------
; INPUT:
; BCD	- [HEX4 | HEX5]
; BCD+1	- [HEX3 | HEX2]
; BCD+2	- [HEX0 | HEX1]
;------------------------------------------------
displayBCD_helper:
	mov dptr, #sevenSegLUT

	; Display HEX 
	mov A, BCD+2
    anl A, #0FH
    movc A, @A+dptr
    mov HEX4, A
    
    mov A, BCD+2
    swap A
    anl A, #0FH
    movc A, @A+dptr
    mov HEX5, A
    
    mov A, BCD+1
    anl A, #0FH
    movc A, @A+dptr
    mov HEX2, A
    
    mov A, BCD+1
    swap A
    anl A, #0FH
    movc A, @A+dptr
    mov HEX3, A

    mov A, BCD
    anl A, #0FH
    movc A, @A+dptr
    mov HEX0, A
    
    mov A, BCD
    swap A
    anl A, #0FH
    movc A, @A+dptr
    mov HEX1, A
	ret
	
$LIST
	