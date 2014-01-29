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
; 	1) soakRate: 	DS 1
; 	2) soakTemp: 	DS 1
; 	3) soakTime:	DS 1
; 	4) reflowRate:	DS 1
; 	5) reflowTemp:	DS 1
; 	6) reflowTime:	DS 1
; 	7) coolRate:	DS 1
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

	ret

$LIST