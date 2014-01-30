;------------------------------------------------
; driver.asm
;------------------------------------------------
; Author: Bibek Kaur
;------------------------------------------------

$NOLIST
CSEG
;-------------------------------------------------------------------------------
;	HELPER:
;-------------------------------------------------------------------------------
	;if T_(current) > T_(desired) : P1.0 on
	;else P1.0 off
	;where T_(desired) is T_(initial) + slope* number of times called in a sec
	;T_(initial) = T(current-1)
;-------------------------------------------------------------------------------
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup_driver( void )
; Setup the ports
;------------------------------------------------
setup_driver:
	mov P1MOD, #0FFH 	;Make all P1 output
	ret
	
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setTemp_driver( temperature [R0] )
; Set the oven target temperature
;------------------------------------------------
; INPUT:
; 	R0 - Contains the desired temperature in celsius (0 - 255)
;------------------------------------------------
setTemp_driver;
	ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void maintainTemp_driver( currentTemp [R0], targetTemp [R1] )
; Tell the driver to maintain target temperature
;------------------------------------------------
; INPUT:
; 	R0 - Contains the current oven temperature (*C)
; 	R1 - Contains the desired temperature (*C)
;------------------------------------------------
maintainTemp_driver:
	ret
	
;------------------------------------------------
; - Private function
;------------------------------------------------
VoltageControlSignal_oven:
	
	ret
	
$LIST	