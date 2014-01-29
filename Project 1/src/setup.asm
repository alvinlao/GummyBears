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
	mov soakRate, #DEFAULT1_SOAKRATE
	mov soakTemp, #DEFAULT1_SOAKTEMP
	mov soakTime, #DEFAULT1_SOAKTIME
	mov reflowRate, #DEFAULT1_reflowRate
	mov reflowTemp, #DEFAULT1_reflowTemp
	mov reflowTime, #DEFAULT1_REFLOWTIME
	mov coolRate, #DEFAULT1_COOLRATE
	
	mov line1_LCD+0, #'C'
	mov line1_LCD+1, #'H'
	mov line1_LCD+2, #'A'
	mov line1_LCD+3, #'N'
	mov line1_LCD+4, #'G'
	mov line1_LCD+5, #'I'
	mov line1_LCD+6, #'N'
	mov line1_LCD+7, #'G'
	mov line1_LCD+8, #'.'
	mov line1_LCD+9, #'.'
	mov line1_LCD+10, #'.'
	mov line1_LCD+11, #' '
	mov line1_LCD+12, #' '
	mov line1_LCD+13, #' '
	mov line1_LCD+14, #' '
	mov line1_LCD+15, #' '

	LCALL setLine1_LCD
	
	mov line2_LCD+0, #'S'
	mov line2_LCD+1, #'e'
	mov line2_LCD+2, #'l'
	mov line2_LCD+3, #'e'
	mov line2_LCD+4, #'c'
	mov line2_LCD+5, #'t'
	mov line2_LCD+6, #' '
	mov line2_LCD+7, #'P'
	mov line2_LCD+8, #'r'
	mov line2_LCD+9, #'o'
	mov line2_LCD+10, #'f'
	mov line2_LCD+11, #'i'
	mov line2_LCD+12, #'l'
	mov line2_LCD+13, #'e'
	mov line2_LCD+14, #' '
	mov line2_LCD+15, #' '
	
	LCALL setLine2_LCD
	
;	soakRate
L0:	
	jnb SWA.0, L1
	
	mov line2_LCD+0, #'0'
	mov line2_LCD+1, #' '
	mov line2_LCD+2, #'S'
	mov line2_LCD+3, #'O'
	mov line2_LCD+4, #'C'
	mov line2_LCD+5, #'K'
	mov line2_LCD+6, #' '
	mov line2_LCD+7, #'R'
	mov line2_LCD+8, #'A'
	mov line2_LCD+9, #'T'
	mov line2_LCD+10, #'E'
	mov line2_LCD+11, #' '
	mov line2_LCD+12, #' '
	mov line2_LCD+13, #' '
	mov line2_LCD+14, #' '
	mov line2_LCD+15, #' '
	
	LCALL setLine2_LCD
	
	MOV X+0, soakRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L01:	
	jb KEY.0, L02
	jnb KEY.0, $
	MOV A, soakRate
	CJNE A, #MAX_SOAKRATE, SHORT0
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
	CJNE A, #MIN_SOAKRATE, SHORTC0
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
	jnb SWA.1, L2
	
	mov line2_LCD+0, #'1'
	mov line2_LCD+1, #' '
	mov line2_LCD+2, #'S'
	mov line2_LCD+3, #'O'
	mov line2_LCD+4, #'C'
	mov line2_LCD+5, #'K'
	mov line2_LCD+6, #' '
	mov line2_LCD+7, #'T'
	mov line2_LCD+8, #'E'
	mov line2_LCD+9, #'M'
	mov line2_LCD+10, #'P'
	mov line2_LCD+11, #'.'
	mov line2_LCD+12, #' '
	mov line2_LCD+13, #' '
	mov line2_LCD+14, #' '
	mov line2_LCD+15, #' '
	
	LCALL setLine2_LCD
	
	MOV X+0, soakTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L11:	
	jb KEY.0, L12
	jnb KEY.0, $
	MOV A, soakTemp
	CJNE A, #MAX_SOAKTEMP, SHORT1
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
	CJNE A, #MIN_SOAKTEMP, SHORTC1
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
	jnb SWA.2, L3
	
	mov line2_LCD+0, #'2'
	mov line2_LCD+1, #' '
	mov line2_LCD+2, #'S'
	mov line2_LCD+3, #'O'
	mov line2_LCD+4, #'C'
	mov line2_LCD+5, #'K'
	mov line2_LCD+6, #' '
	mov line2_LCD+7, #'T'
	mov line2_LCD+8, #'I'
	mov line2_LCD+9, #'M'
	mov line2_LCD+10, #'E'
	mov line2_LCD+11, #' '
	mov line2_LCD+12, #' '
	mov line2_LCD+13, #' '
	mov line2_LCD+14, #' '
	mov line2_LCD+15, #' '
	
	LCALL setLine2_LCD
	
	MOV X+0, soakTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L21:	
	jb KEY.0, L22
	jnb KEY.0, $
	MOV A, soakTime
	CJNE A, #MAX_SOAKTIME, SHORT2
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
	CJNE A, #MIN_SOAKTIME, SHORTC2
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
	jnb SWA.3, L4
	
	mov line2_LCD+0, #'3'
	mov line2_LCD+1, #' '
	mov line2_LCD+2, #'R'
	mov line2_LCD+3, #'E'
	mov line2_LCD+4, #'F'
	mov line2_LCD+5, #'L'
	mov line2_LCD+6, #'O'
	mov line2_LCD+7, #'W'
	mov line2_LCD+8, #' '
	mov line2_LCD+9, #'R'
	mov line2_LCD+10, #'A'
	mov line2_LCD+11, #'T'
	mov line2_LCD+12, #'E'
	mov line2_LCD+13, #' '
	mov line2_LCD+14, #' '
	mov line2_LCD+15, #' '
	
	LCALL setLine2_LCD
	
	MOV X+0, reflowRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L31:	
	jb KEY.0, L32
	jnb KEY.0, $
	MOV A, reflowRate
	CJNE A, #MAX_reflowRate, SHORT3
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
	CJNE A, #MIN_reflowRate, SHORTC3
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
	jnb SWA.4, L5
	
	mov line2_LCD+0, #'4'
	mov line2_LCD+1, #' '
	mov line2_LCD+2, #'R'
	mov line2_LCD+3, #'E'
	mov line2_LCD+4, #'F'
	mov line2_LCD+5, #'L'
	mov line2_LCD+6, #'O'
	mov line2_LCD+7, #'W'
	mov line2_LCD+8, #' '
	mov line2_LCD+9, #'T'
	mov line2_LCD+10, #'E'
	mov line2_LCD+11, #'M'
	mov line2_LCD+12, #'P'
	mov line2_LCD+13, #' '
	mov line2_LCD+14, #' '
	mov line2_LCD+15, #' '
	
	LCALL setLine2_LCD
	
	MOV X+0, reflowTemp
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L41:	
	jb KEY.0, L42
	jnb KEY.0, $
	MOV A, reflowTemp
	CJNE A, #MAX_reflowTemp, SHORT4
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
	CJNE A, #MIN_reflowTemp, SHORTC4
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
	jnb SWA.5, L6
	
	mov line2_LCD+0, #'5'
	mov line2_LCD+1, #' '
	mov line2_LCD+2, #'R'
	mov line2_LCD+3, #'E'
	mov line2_LCD+4, #'F'
	mov line2_LCD+5, #'L'
	mov line2_LCD+6, #'O'
	mov line2_LCD+7, #'W'
	mov line2_LCD+8, #' '
	mov line2_LCD+9, #'T'
	mov line2_LCD+10, #'I'
	mov line2_LCD+11, #'M'
	mov line2_LCD+12, #'E'
	mov line2_LCD+13, #' '
	mov line2_LCD+14, #' '
	mov line2_LCD+15, #' '
	
	LCALL setLine2_LCD
	
	MOV X+0, reflowTime
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L51:	
	jb KEY.0, L52
	jnb KEY.0, $
	MOV A, reflowTime
	CJNE A, #MAX_reflowTime, SHORT5
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
	CJNE A, #MIN_reflowTime, SHORTC5
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
	jnb SWA.6, L7
	
	mov line2_LCD+0, #'6'
	mov line2_LCD+1, #' '
	mov line2_LCD+2, #'C'
	mov line2_LCD+3, #'O'
	mov line2_LCD+4, #'O'
	mov line2_LCD+5, #'L'
	mov line2_LCD+6, #' '
	mov line2_LCD+7, #'R'
	mov line2_LCD+8, #'A'
	mov line2_LCD+9, #'T'
	mov line2_LCD+10, #'E'
	mov line2_LCD+11, #' '
	mov line2_LCD+12, #' '
	mov line2_LCD+13, #' '
	mov line2_LCD+14, #' '
	mov line2_LCD+15, #' '
	
	LCALL setLine2_LCD
	
	MOV X+0, coolRate
	MOV X+1, #00H
	
	LCALL hex2bcd
	LCALL displayBCD_helper
	
L61:	
	jb KEY.0, L62
	jnb KEY.0, $
	MOV A, coolRate
	CJNE A, #MAX_coolRate, SHORT6
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
	CJNE A, #MIN_coolRate, SHORTC6
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
	ret

$LIST

	
	
	