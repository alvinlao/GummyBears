;------------------------------------------------
; setup.asm
;------------------------------------------------
; Initial setup loop
; Allow user to set reflow soldering parameters
;------------------------------------------------
; Author: 
;------------------------------------------------

$NOLIST
CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void go_setup( void )
; Entry function for the initial setup loop
;------------------------------------------------
; ENSURES:
; 	The following parameters should be set
; 	1) soakRate: 	DS 1	->SWA.0
; 	2) soakTemp: 	DS 1	->SWA.1
; 	3) soakTime:	DS 1	->SWA.2
; 	4) reflowRate:	DS 1	->SWA.3
; 	5) reflowTemp:	DS 1	->SWA.4
; 	6) reflowTime:	DS 1	->SWA.5
; 	7) coolRate:	DS 1	->SWA.6
;------------------------------------------------
go_setup:

	mov dptr, #DEFAULT1_SOAKRATE
	lcall getCodeByte_helper
	mov soakRate, R0

	mov dptr, #DEFAULT1_SOAKTEMP
	lcall getCodeByte_helper
	mov soakTemp, R0
	
	mov dptr, #DEFAULT1_SOAKTIME
	lcall getCodeByte_helper
	mov soakTime, R0
	
	mov dptr, #DEFAULT1_REFLOWTIME
	lcall getCodeByte_helper
	mov reflowTime, R0
	
	mov dptr, #DEFAULT1_REFLOWRATE
	lcall getCodeByte_helper
	mov reflowRate, R0
	
	mov dptr, #DEFAULT1_REFLOWTEMP
	lcall getCodeByte_helper
	mov reflowTemp, R0        
	
	mov dptr, #DEFAULT1_COOLRATE
	lcall getCodeByte_helper
	mov coolRate, R0
	
;	soakRate
L00:	
	JB SWA.7, L7
	jnb SWA.0, L7
	
	mov dptr, #SETSOAKRATE_STRINGS
	LCALL displayStringFromCode_LCD
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L01:	
	jb KEY.3, L02
	jnb KEY.3, $
	MOV A, soakRate
	mov dptr, #MAX_SOAKRATE
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, soakRate
	CJNE A, compare, SHORT0
	SJMP L02
SHORT0:
	INC A
	MOV soakRate, A
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L02:
	jb KEY.2, L03
	jnb KEY.2, $
	MOV A, soakRate
	mov dptr, #MIN_SOAKRATE
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, soakRate
	CJNE A, compare, SHORTC0
	SJMP L03
SHORTC0:
	DEC A
	MOV soakRate, A
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L03:	
	LJMP L00

L7:
	JB SWA.7, L8
	LJMP L00
L8: 
	RET

$LIST

	
	
	