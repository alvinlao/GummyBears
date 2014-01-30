;------------------------------------------------
; driver.asm
;------------------------------------------------
; Author: Bibek Kaur
;------------------------------------------------

$NOLIST
CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup_driver( void )
; Setup port 1 output pins
;------------------------------------------------
setup_driver:
	mov P1MOD, #0FFH 	;Make all P1 output
	ret
	
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setRamp_driver( prevTemp [R0], curTemp [R1], rate [R2] )
; Increase oven temperature at specified rate 
;------------------------------------------------
; INPUT:
; 	R0 - Previous temperature in celsius (0 - 255)
; 	R1 - Current temperature in celsius (0 - 255)
; 	R2 - Ramp rate in *C/s (0 - 255)
;------------------------------------------------
setRamp_driver:
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void maintainTemp_driver( curTemp [R0], targetTemp [R1] )
; Tell the driver to maintain target temperature
;------------------------------------------------
; INPUT:
; 	R0 - Contains the current oven temperature (*C)
; 	R1 - Contains the desired temperature (*C)
;------------------------------------------------
maintainTemp_driver:
	ret
	
	
$LIST	