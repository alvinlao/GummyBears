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
	mov soakRate, DEFAULT1_SOAKRATE
	mov soakTemp, DEFAULT1_SOAKTEMP
	mov soakTime, DEFAULT1_SOAKTIME
	mov reflowTime, DEFAULT1_REFLOWTIME
	mov reflowRate, DEFAULT1_reflowRate
	mov reflowTemp, DEFAULT1_reflowTemp
	mov coolRate, DEFAULT1_COOLRATE
	
	ret

$LIST