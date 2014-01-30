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
L0:	
	JB SWA.7, L1
	jnb SWA.0, L1
	
	mov dptr, #SETSOAKRATE_STRINGS
	LCALL loadString_LCD
	LCALL displayStringFromCode_LCD
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L01:	
	jb KEY.0, L02
	jnb KEY.0, $
	MOV A, soakRate
	mov dptr, #MAX_SOAKRATE
	lcall getCodeByte_helper
	CJNE A, R0, SHORT0
	SJMP L02
SHORT0:
	INC A
	MOV soakRate, A
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L02:
	jb KEY.1, L03
	jnb KEY.1, $
	MOV A, soakRate
	mov dptr, #MIN_SOAKRATE
	lcall getCodeByte_helper
	CJNE A, R0, SHORTC0
	SJMP L03
SHORTC0:
	DEC A
	MOV soakRate, A
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L03:	
	LJMP L0
	
;	soakTemp
L1:
	JB SWA.7, L2
	jnb SWA.1, L2
	
	mov dptr, #SETSOAKTEMPERATURE_STRINGS
	LCALL loadString_LCD
	LCALL displayStringFromCode_LCD
	
	MOV X+0, soakTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L11:	
	jb KEY.0, L12
	jnb KEY.0, $
	MOV A, soakTemp
	mov dptr, #MAX_SOAKTEMP
	lcall getCodeByte_helper
	CJNE A, R0, SHORT1
	SJMP L12
SHORT1:
	INC A
	MOV soakTemp, A
	
	MOV X+0, soakTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L12:
	jb KEY.1, L13
	jnb KEY.1, $
	MOV A, soakTemp
	mov dptr, #MIN_SOAKTEMP
	lcall getCodeByte_helper
	CJNE A, R0, SHORTC1
	SJMP L13
SHORTC1:
	DEC A
	MOV soakTemp, A
	
	MOV X+0, soakTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L13:	
	LJMP L1
	
;	soakTime
L2:
	JB SWA.7, L3
	jnb SWA.2, L3
	
	mov dptr, #SETSOAKTIME_STRINGS
	LCALL loadString_LCD
	LCALL displayStringFromCode_LCD
	
	MOV X+0, soakTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L21:	
	jb KEY.0, L22
	jnb KEY.0, $
	MOV A, soakTime
	mov dptr, #MAX_SOAKTIME
	lcall getCodeByte_helper
	CJNE A, R0, SHORT2
	SJMP L22
SHORT2:
	INC A
	MOV soakTime, A
	
	MOV X+0, soakTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L22:
	jb KEY.1, L23
	jnb KEY.1, $
	MOV A, soakTime
	mov dptr, #MIN_SOAKTIME
	lcall getCodeByte_helper
	CJNE A, R0, SHORTC2
	SJMP L23
SHORTC2:
	DEC A
	MOV soakTime, A
	
	MOV X+0, soakTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L23:	
	LJMP L2
	
;	reflowRate
L3:
	JB SWA.7, L4
	jnb SWA.3, L4
	
	mov dptr, #SETREFLOWRATE_STRINGS
	LCALL loadString_LCD
	LCALL displayStringFromCode_LCD
	
	MOV X+0, reflowRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L31:	
	jb KEY.0, L32
	jnb KEY.0, $
	MOV A, reflowRate
	mov dptr, #MAX_reflowRate
	lcall getCodeByte_helper
	CJNE A, R0, SHORT3
	SJMP L32
SHORT3:
	INC A
	MOV reflowRate, A
	
	MOV X+0, reflowRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L32:
	jb KEY.1, L33
	jnb KEY.1, $
	MOV A, reflowRate
	mov dptr, #MIN_reflowRate
	lcall getCodeByte_helper
	CJNE A, R0, SHORTC3
	SJMP L33
SHORTC3:
	DEC A
	MOV reflowRate, A
	
	MOV X+0, reflowRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L33:	
	LJMP L3
	
;	reflowTemp	
L4:
	JB SWA.7, L5
	jnb SWA.4, L5
	
	mov dptr, #SETREFLOWTEMP_STRINGS
	LCALL loadString_LCD
	LCALL displayStringFromCode_LCD
	
	MOV X+0, reflowTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L41:	
	jb KEY.0, L42
	jnb KEY.0, $
	MOV A, reflowTemp
	mov dptr, #MAX_REFLOWTEMP
	lcall getCodeByte_helper
	CJNE A, R0, SHORT4
	SJMP L42
SHORT4:
	INC A
	MOV reflowTemp, A
	
	MOV X+0, reflowTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L42:
	jb KEY.1, L43
	jnb KEY.1, $
	MOV A, reflowTemp
	mov dptr, #MIN_REFLOWTEMP
	lcall getCodeByte_helper
	CJNE A, R0, SHORTC4
	SJMP L43
SHORTC4:
	DEC A
	MOV reflowTemp, A
	
	MOV X+0, reflowTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L43:	
	LJMP L4
	
;	reflowTime
L5:
	JB SWA.7, L6
	jnb SWA.5, L6
	
	mov dptr, #SETREFLOWTIME_STRINGS
	LCALL loadString_LCD
	LCALL displayStringFromCode_LCD
	
	MOV X+0, reflowTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L51:	
	jb KEY.0, L52
	jnb KEY.0, $
	MOV A, reflowTime
	mov dptr, #MAX_REFLOWTIME
	lcall getCodeByte_helper
	CJNE A, R0, SHORT5
	SJMP L52
SHORT5:
	INC A
	MOV reflowTime, A
	
	MOV X+0, reflowTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L52:
	jb KEY.1, L53
	jnb KEY.1, $
	MOV A, reflowTime
	mov dptr, #MIN_REFLOWTIME
	lcall getCodeByte_helper
	CJNE A, R0, SHORTC5
	SJMP L53
SHORTC5:
	DEC A
	MOV reflowTime, A
	
	MOV X+0, reflowTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L53:	
	LJMP L5

;	coolRate
L6:
	JB SWA.7, L8
	jnb SWA.6, L7
	
	mov dptr, #SETCOOLRATE_STRINGS
	LCALL loadString_LCD
	LCALL displayStringFromCode_LCD
	
	MOV X+0, coolRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L61:	
	jb KEY.0, L62
	jnb KEY.0, $
	MOV A, coolRate
	mov dptr, #MAX_COOLRATE
	lcall getCodeByte_helper
	CJNE A, R0, SHORT6
	SJMP L62
SHORT6:
	INC A
	MOV coolRate, A
	
	MOV X+0, coolRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L62:
	jb KEY.1, L63
	jnb KEY.1, $
	MOV A, coolRate
	mov dptr, #MIN_COOLRATE
	lcall getCodeByte_helper
	CJNE A, R0, SHORTC6
	SJMP L63
SHORTC6:
	DEC A
	MOV coolRate, A
	
	MOV X+0, coolRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L63:	
	LJMP L6
L7:
	JB SWA.7, L8
	LJMP L0
L8: 
	RET

$LIST

	
	
	