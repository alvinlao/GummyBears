;------------------------------------------------
; finish.asm
;------------------------------------------------
; Contains clean up code (things that need to be done before the program exits)
; Perhaps LCD animation and buzzer music?
;------------------------------------------------
; DEPENDENCIES:
;	oven/driver.asm
;	util/buzzer.asm
;	util/LCD.asm
;------------------------------------------------
; Author: 
;------------------------------------------------

$NOLIST
CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void go_finish( void )
; Entry function for the final exit code
;------------------------------------------------
go_finish:
	mov dptr , #FINISHED_STRINGS
	lcall displayStringFromCode_LCD
	lcall sixBeeps_buzzer
	clr EA							;Stop interrupts
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void force_finish( void )
; Handle user force stop action
;------------------------------------------------
force_finish:
	clr EA							;Stop interrupts
	mov dptr, #STOPPED_STRINGS
	lcall displayStringFromCode_LCD
	lcall off_driver		;Turn off the oven
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void hot_finish( void )
; Handle over heat finish
;------------------------------------------------
hot_finish:
	clr EA							;Stop interrupts
	mov dptr, #OVERHEAT_STRINGS
	lcall displayStringFromCode_LCD
	lcall off_driver		;Turn off the oven
	ret
$LIST
