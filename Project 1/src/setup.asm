;------------------------------------------------
; setup.asm
;------------------------------------------------
; Initial setup loop
; Allow user to set reflow soldering parameters
;------------------------------------------------
; Author: Bibek Kaur
;------------------------------------------------

$NOLIST
CSEG


WaitHalfSec_SETUP:
	mov R7, #180
L3_SETUP: mov R6, #250
L2_SETUP: mov R5, #250
L1_SETUP: djnz R5, L1_SETUP ; 3 machine cycles-> 3*30ns*250=22.5us
	djnz R6, L2_SETUP ; 22.5us*250=5.625ms
	djnz R7, L3_SETUP ; 5.625ms*90=0.5s (approximately)
	ret


;------------------------------------------------    
; + Public function
;------------------------------------------------
; void ext_setup( void )
; Waits for setup information from serial port
;------------------------------------------------
; PROTOCOL:
;	Waits for 7 bytes of data
;------------------------------------------------
ext_setup:
	;Setup pointers to our variables
	mov setupPointer, #soakRate
	mov setupFinish, #setupFinish
	setb EA
	
	;Display waiting for computer
	mov dptr, #WAIT_EXT_STRINGS
	lcall displayStringFromCode_LCD
	
ext_waitVars_setup:
	;If setupPointer == setupFinish
	mov A, setupPointer
	cjne A, setupFinish, ext_waitVars_setup
	
	;Got computer variables
	clr EA		; Stop interrupts
	clr ES
	
	;Display on LCD
	mov dptr, #FINISH_EXT_STRINGS
	lcall displayStringFromCode_LCD	
	
	;Wait for start switch
ext_waitStart_setup:
	mov a, SWC
	anl a, #00000010B
	jz ext_waitStart_setup
	ret


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
	
DEFAULT1_setup:
	MOV A, #01111111B
	MOV HEX0, A
	MOV HEX1, A
	MOV HEX2, A
	
	mov dptr, #WELCOME_STRINGS
	LCALL displayStringFromCode_LCD
	
	jb KEY.1, DEFAULT2_setup
	jnb KEY.1, $
	
	mov dptr, #DEFAULT1_STRINGS
	LCALL displayStringFromCode_LCD
	
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
	
	lcall WaitHalfSec_SETUP
DEFAULT2_setup:
	jb KEY.2, DEFAULT3_setup
	jnb KEY.2, $
	
	mov dptr, #DEFAULT2_STRINGS
	LCALL displayStringFromCode_LCD
	
	mov dptr, #DEFAULT2_SOAKRATE
	lcall getCodeByte_helper
	mov soakRate, R0

	mov dptr, #DEFAULT2_SOAKTEMP
	lcall getCodeByte_helper
	mov soakTemp, R0
	
	mov dptr, #DEFAULT2_SOAKTIME
	lcall getCodeByte_helper
	mov soakTime, R0
	
	mov dptr, #DEFAULT2_REFLOWTIME
	lcall getCodeByte_helper
	mov reflowTime, R0
	
	mov dptr, #DEFAULT2_REFLOWRATE
	lcall getCodeByte_helper
	mov reflowRate, R0
	
	mov dptr, #DEFAULT2_REFLOWTEMP
	lcall getCodeByte_helper
	mov reflowTemp, R0        
	
	mov dptr, #DEFAULT2_COOLRATE
	lcall getCodeByte_helper
	mov coolRate, R0
	
	lcall WaitHalfSec_SETUP
DEFAULT3_setup:
	jb KEY.3, L00_setup
	jnb KEY.3, $
	
	mov dptr, #DEFAULT3_STRINGS
	LCALL displayStringFromCode_LCD
	
	mov dptr, #DEFAULT3_SOAKRATE
	lcall getCodeByte_helper
	mov soakRate, R0

	mov dptr, #DEFAULT3_SOAKTEMP
	lcall getCodeByte_helper
	mov soakTemp, R0
	
	mov dptr, #DEFAULT3_SOAKTIME
	lcall getCodeByte_helper
	mov soakTime, R0
	
	mov dptr, #DEFAULT3_REFLOWTIME
	lcall getCodeByte_helper
	mov reflowTime, R0
	
	mov dptr, #DEFAULT3_REFLOWRATE
	lcall getCodeByte_helper
	mov reflowRate, R0
	
	mov dptr, #DEFAULT3_REFLOWTEMP
	lcall getCodeByte_helper
	mov reflowTemp, R0        
	
	mov dptr, #DEFAULT3_COOLRATE
	lcall getCodeByte_helper
	mov coolRate, R0

	lcall WaitHalfSec_SETUP
;	soakRate
L00_setup:	
	
	
	mov a, SWC
	anl a, #00000010B
	jnz L10_setup
	jnb SWA.0, L10_setup
	
	mov dptr, #SETSOAKRATE_STRINGS
	LCALL displayStringFromCode_LCD
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L01_setup:	
	jb KEY.3, L02_setup
	jnb KEY.3, $
	MOV A, soakRate
	mov dptr, #MAX_SOAKRATE
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, soakRate
	CJNE A, compare, SHORT0
	SJMP L02_setup
SHORT0:
	INC A
	MOV soakRate, A
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L02_setup:
	jb KEY.2, L03_setup
	jnb KEY.2, $
	MOV A, soakRate
	mov dptr, #MIN_SOAKRATE
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, soakRate
	CJNE A, compare, SHORTC0
	SJMP L03_setup
SHORTC0:
	DEC A
	MOV soakRate, A
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L03_setup:	
	LJMP L00_setup
	
;	soakTemp
L10_setup:
	
	
	mov a, SWC
	anl a, #00000010B
	jnz L20_setup
	jnb SWA.1, L20_setup
	
	mov dptr, #SETSOAKTEMPERATURE_STRINGS
	LCALL displayStringFromCode_LCD
	
	MOV X+0, soakTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L11_setup:	
	jb KEY.3, L12_setup
	jnb KEY.3, $
	MOV A, soakTemp
	mov dptr, #MAX_SOAKTEMP
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, soakTemp
	CJNE A, compare, SHORT1
	SJMP L12_setup
SHORT1:
	INC A
	MOV soakTemp, A
	
	MOV X+0, soakTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L12_setup:
	jb KEY.2, L13_setup
	jnb KEY.2, $
	MOV A, soakTemp
	mov dptr, #MIN_SOAKTEMP
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, soakTemp
	CJNE A, compare, SHORTC1
	SJMP L13_setup
SHORTC1:
	DEC A
	MOV soakTemp, A
	
	MOV X+0, soakTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L13_setup:	
	LJMP L10_setup
	
;	soakTime
L20_setup:
	
	
	mov a, SWC
	anl a, #00000010B
	jnz L30_setup
	jnb SWA.2, L30_setup
	
	mov dptr, #SETSOAKTIME_STRINGS
	LCALL displayStringFromCode_LCD
	
	MOV X+0, soakTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L21_setup:	
	jb KEY.3, L22_setup
	jnb KEY.3, $
	MOV A, soakTime
	mov dptr, #MAX_SOAKTIME
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, soakTime
	CJNE A, compare, SHORT2
	SJMP L22_setup
SHORT2:
	INC A
	MOV soakTime, A
	
	MOV X+0, soakTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L22_setup:
	jb KEY.2, L23_setup
	jnb KEY.2, $
	MOV A, soakTime
	mov dptr, #MIN_SOAKTIME
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, soakTime
	CJNE A, compare, SHORTC2
	SJMP L23_setup
SHORTC2:
	DEC A
	MOV soakTime, A
	
	MOV X+0, soakTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L23_setup:	
	LJMP L20_setup
	
;	reflowRate
L30_setup:
	
	
	mov a, SWC
	anl a, #00000010B
	jnz L40_setup
	jnb SWA.3, L40_setup
	
	mov dptr, #SETREFLOWRATE_STRINGS
	LCALL displayStringFromCode_LCD
	
	MOV X+0, reflowRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L31_setup:	
	jb KEY.3, L32_setup
	jnb KEY.3, $
	MOV A, reflowRate
	mov dptr, #MAX_reflowRate
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, reflowRate
	CJNE A, compare, SHORT3
	SJMP L32_setup
SHORT3:
	INC A
	MOV reflowRate, A
	
	MOV X+0, reflowRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L32_setup:
	jb KEY.2, L33_setup
	jnb KEY.2, $
	MOV A, reflowRate
	mov dptr, #MIN_reflowRate
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, reflowRate
	CJNE A, compare, SHORTC3
	SJMP L33_setup
SHORTC3:
	DEC A
	MOV reflowRate, A
	
	MOV X+0, reflowRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L33_setup:	
	LJMP L30_setup
	
;	reflowTemp	
L40_setup:
	
	
	mov a, SWC
	anl a, #00000010B
	jnz L5_setup
	jnb SWA.4, L5_setup
	
	mov dptr, #SETREFLOWTEMP_STRINGS
	LCALL displayStringFromCode_LCD
	
	MOV X+0, reflowTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L41_setup:	
	jb KEY.3, L42_setup
	jnb KEY.3, $
	MOV A, reflowTemp
	mov dptr, #MAX_REFLOWTEMP
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, reflowTemp
	CJNE A, compare, SHORT4
	SJMP L42_setup
SHORT4:
	INC A
	MOV reflowTemp, A
	
	MOV X+0, reflowTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L42_setup:
	jb KEY.2, L43_setup
	jnb KEY.2, $
	MOV A, reflowTemp
	mov dptr, #MIN_REFLOWTEMP
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, reflowTemp
	CJNE A, compare, SHORTC4
	SJMP L43_setup
SHORTC4:
	DEC A
	MOV reflowTemp, A
	
	MOV X+0, reflowTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L43_setup:	
	LJMP L40_setup
	
;	reflowTime
L5_setup:
	
	
	mov a, SWC
	anl a, #00000010B
	jnz L6_setup
	jnb SWA.5, L6_setup
	
	mov dptr, #SETREFLOWTIME_STRINGS
	LCALL displayStringFromCode_LCD
	
	MOV X+0, reflowTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L51_setup:	
	jb KEY.3, L52_setup
	jnb KEY.3, $
	MOV A, reflowTime
	mov dptr, #MAX_REFLOWTIME
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, reflowTime
	CJNE A, compare, SHORT5
	SJMP L52_setup
SHORT5:
	INC A
	MOV reflowTime, A
	
	MOV X+0, reflowTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L52_setup:
	jb KEY.2, L53_setup
	jnb KEY.2, $
	MOV A, reflowTime
	mov dptr, #MIN_REFLOWTIME
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, reflowTime
	CJNE A, compare, SHORTC5
	SJMP L53_setup
SHORTC5:
	DEC A
	MOV reflowTime, A
	
	MOV X+0, reflowTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L53_setup:	
	LJMP L5_setup

;	coolRate
L6_setup:
	
	
	mov a, SWC
	anl a, #00000010B
	jnz L7_setup
	jnb SWA.6, L7_setup
	
	mov dptr, #SETCOOLRATE_STRINGS
	LCALL displayStringFromCode_LCD
	
	MOV X+0, coolRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L61_setup:	
	jb KEY.3, L62_setup
	jnb KEY.3, $
	MOV A, coolRate
	mov dptr, #MAX_COOLRATE
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, coolRate
	CJNE A, compare, SHORT6
	SJMP L62_setup
SHORT6:
	INC A
	MOV coolRate, A
	
	MOV X+0, coolRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L62_setup:
	jb KEY.2, L63_setup
	jnb KEY.2, $
	MOV A, coolRate
	mov dptr, #MIN_COOLRATE
	lcall getCodeByte_helper
	mov compare, R0
	MOV A, coolRate
	CJNE A, compare, SHORTC6
	SJMP L63_setup
SHORTC6:
	DEC A
	MOV coolRate, A
	
	MOV X+0, coolRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
L63_setup:	
	LJMP L6_setup
L7_setup:
	mov a, SWC
	anl a, #00000010B
	jnz L8_setup
	LJMP DEFAULT1_setup
L8_setup: 
	mov currentState, #1
	RET

$LIST

	
	
	
