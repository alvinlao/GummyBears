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
;	prevTemp
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
	mov x+0, currentState
	mov x+1, #0
	
	mov y+0, #2
	mov y+1, #0
	lcall x_eq_y
	jb mf, state2_controller
	
	mov y+0, #3
	mov y+1, #0
	lcall x_eq_y
	jb mf, state3_controller
	
	mov y+0, #4
	mov y+1, #0
	lcall x_eq_y
	jnb mf, continueState1_1_controller
	ljmp state4_controller
	
continueState1_1_controller:	
	mov y+0, #5
	mov y+1, #0
	lcall x_eq_y
	jnb mf, continueState1_2_controller
	ljmp state5_controller
	
continueState1_2_controller:	
;	In state 1:	
	mov x+0, currentTemp
	mov x+1, #0
	mov y+0, soakTemp
	mov y+1, #0
	lcall x_gteq_y	;if true change state to 2, call buzzer, call maintainTemp_driver
	
	mov R0, PrevTemp
	mov R1, currentTemp
	mov R2, soakRate
	jnb mf, shortcut_controller
	
	mov currentState, #2
	mov currentStateTime, #0
	lcall shortBeep_buzzer
	
	mov R0, currentTemp
	mov R1, SoakTemp
	ljmp maintainTemp_driver_controller

;	In state 2:	
state2_controller:
	mov x+0, currentStateTime
	mov x+1, #0
	mov y+0, soakTime
	mov y+1, #0
	lcall x_gteq_y	
	
	mov R0, currentTemp
	mov R1, SoakTemp
	jnb mf, maintainTemp_driver_controller
	
	mov currentstate, #3
	lcall shortBeep_buzzer
	mov R0, PrevTemp
	mov R1, currentTemp
	mov R2, reflowRate
shortcut_controller:
	ljmp setRamp_driver_controller
	
state3_controller:
	mov x+0, currentTemp
	mov x+1, #0
	mov y+0, ReflowTemp
	mov y+1, #0
	lcall x_gteq_y
	
	mov R0, PrevTemp
	mov R1, currentTemp
	mov R2, reflowRate
	jnb mf, setRamp_driver_controller
	
	mov currentstate, #4
	lcall shortBeep_buzzer
	
	mov R0, currentTemp
	mov R1, reflowTemp
	ljmp maintainTemp_driver_controller
	
state4_controller:
	mov x+0, currentStateTime
	mov x+1, #0
	mov y+0, reflowTime
	mov y+1, #0
	lcall x_gteq_y
	
	mov R0, currentTemp
	mov R1, ReflowTemp
	jnb mf, maintainTemp_driver_controller
	
	mov currentstate, #5
	lcall longBeep_buzzer
	
	ljmp return_controller
	
state5_controller:
	mov x+0, currentTemp
	mov x+1, #0
	mov dptr, #FINISH_TEMP
	lcall getCodeByte_helper
	mov y+0, R0
	mov y+1, #0
	lcall x_lteq_y
	
	jnb mf, return_controller
	
	mov currentstate, #6
	LCALL sixBeeps_buzzer
	lcall return_controller
	
setRamp_driver_controller:
	lcall setRamp_driver
	sjmp return_controller
	
maintainTemp_driver_controller:	
	lcall maintainTemp_driver
	
return_controller:
	ret

$LIST
