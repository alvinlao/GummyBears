;------------------------------------------------
; live.asm
;------------------------------------------------
; Update the board state during reflow soldering
;------------------------------------------------
; DEPENDENCIES:
;	util/LCD.asm
;------------------------------------------------
; Author: 
;------------------------------------------------

$NOLIST
CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void update_live( void )
; Display on the altera board:
; 	1) Current temperature
;	2) Running time
;	3) Current reflow process
;------------------------------------------------
; REQUIRES:
;	global var currentTemp (1 byte)
;------------------------------------------------
update_live:
	ret

$LIST