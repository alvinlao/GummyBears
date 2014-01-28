;------------------------------------------------
; LCD.asm
;------------------------------------------------
; Provides functions for using the LCD
;------------------------------------------------
; Author: 
;------------------------------------------------

$NOLIST
DSEG
	line1_LCD:	DS 80
	line2_LCD:	DS 80
	
CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setLine1_LCD( void )
; Updates the first line of the LCD screen with the contents of LCD1
;------------------------------------------------
setLCD1_LCD:
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setLine2_LCD( void )
; Updates the second line of the LCD screen with the contents of LCD2
;------------------------------------------------
setLCD2_LCD:
	ret

$LIST