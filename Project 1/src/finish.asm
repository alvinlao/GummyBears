;------------------------------------------------
; finish.asm
;------------------------------------------------
; Called after the reflow soldering
; Perhaps LCD animation and buzzer music?
;------------------------------------------------
; DEPENDENCIES:
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
	ret

$LIST