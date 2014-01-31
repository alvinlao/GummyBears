;------------------------------------------------
; driver.asm
;------------------------------------------------
; Author: Bibek Kaur/Alvin Lao
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
; LOGIC:
;	delta = curTemp - prevTemp
;	if(delta <= rate) ovenOn()
;	else ovenOff()
;------------------------------------------------
setRamp_driver:
	clr c
	mov A, R1
	subb A, R0
	jc on_driver		 	;Cooling (!)
	mov x, A
	mov y, R2
	lcall x_lteq_y
	jb mf, on_driver		;OvenOn
	sjmp off_driver			;OvenOff
setRamp_finish_driver:
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
; LOGIC:
;	delta = target - curTemp
;	if(delta == 0) ovenOff
;	if(delta > 0) ovenOn
;	else ovenOff
;------------------------------------------------
maintainTemp_driver:
	clr c
	mov A, R1
	subb A, R0
	jz A, off_driver		;Delta == 0
	mov x, A
	mov y, #0	
	lcall x_gt_y
	jb mf, on_driver		;Delta > 0
	sjmp off_driver			;Delta < 0

;------------------------------------------------    
; - Private function
;------------------------------------------------
; void on_driver( void )
; Turn oven switch on
;------------------------------------------------
on_driver:
	setb P1.0
	ret

;------------------------------------------------    
; - Private function
;------------------------------------------------
; void on_driver( void )
; Turn oven switch on
;------------------------------------------------
off_driver:
	clr P1.0
	ret


$LIST	
