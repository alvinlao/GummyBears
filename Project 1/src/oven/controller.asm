;------------------------------------------------
; controller.asm
;------------------------------------------------
; Control the oven as specified by the reflow soldering parameters
;------------------------------------------------
; DEPENDENCIES:
;	driver.asm
;	../util/buzzer.asm
;------------------------------------------------
; Author: Alvin Lao
;------------------------------------------------

$NOLIST
CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void update_controller( void )
; Called every second during reflow soldering to set new oven target temperature
;------------------------------------------------
; REQUIRES:
;	soakRate
;	soakTemp
;	soakTime
;	reflowRate
;	reflowTemp
;	reflowTime
;	coolRate
;------------------------------------------------
; ENSURES:
; 	Every stage transition, make a short beep (use util/buzzer.asm)
;------------------------------------------------
; INPUT:
; 	R0 - Contains the desired temperature in celsius (0 - 255)
;------------------------------------------------
update_oven:
	ret

$LIST
