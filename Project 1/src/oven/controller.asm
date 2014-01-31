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
; void setup_controller( void )
; Must be called before the controller is used
;------------------------------------------------
; REQUIRES:
;	Setup timer0 for 1 second interrupts
;------------------------------------------------
setup_controller:
	
	ret

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
;
;	currentTemp
;	currentState
;	currentStateTime
;------------------------------------------------
; MODIFIES:
;	currentTemp - Update current oven temperature
;	currentState - Updates current state
;	currentStateTime - Reset every change of state
;------------------------------------------------
; ENSURES:
; 	Every stage transition, make a short beep (use util/buzzer.asm)
;------------------------------------------------
update_controller:
	
	ret

$LIST
