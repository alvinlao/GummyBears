;------------------------------------------------
; helper.asm
;------------------------------------------------
; Interface for LCD display
;------------------------------------------------
; DEPENDENCIES:
;		helper.asm
;------------------------------------------------
; Author: Jesus/David/Bibek
;------------------------------------------------

$NOLIST
CSEG


;------------------------------------------------    
; - Private macro
;------------------------------------------------    
; Put character at desired position
;------------------------------------------------
;	INPUT:
;		%0 - Position (See command_LCD argument)
;		%1 - Character (See put_LCD argument)
;------------------------------------------------
name_LCD MAC 

ENDMAC


;------------------------------------------------    
; - Private function
;------------------------------------------------    
; Move LCD pointer to desiered position
;------------------------------------------------    
; INPUT:
;	A - #80H (first position) to #0CFH (last position)
;------------------------------------------------
command_LCD:
	mov	LCD_DATA, A
	clr	LCD_RS
	nop
	nop
	setb LCD_EN ; Enable pulse should be at least 230 ns
	nop
	nop
	nop
	nop
	nop
	nop
	clr	LCD_EN
	ljmp Wait40us_helper

;------------------------------------------------    
; - Private function
;------------------------------------------------    
; Put character at LCD pointer position 
;------------------------------------------------    
; INPUT:
;	A - ASCII encoded character
;------------------------------------------------
put_LCD:
	mov	LCD_DATA, A
	setb LCD_RS
	nop
	nop
	setb LCD_EN ; Enable pulse should be at least 230 ns
	nop
	nop
	nop
	nop
	nop
	nop
	clr	LCD_EN
	ljmp Wait40us_helper
	

;------------------------------------------------    
; + Public function
;------------------------------------------------    
; Setup LCD
; 	Must be called before using other LCD functions
;------------------------------------------------     
setup_LCD:    
    ; Turn LCD on, and wait a bit.
    setb LCD_ON
    clr LCD_EN  ; Default state of enable must be zero
    lcall Wait40us_helper
    
    mov LCD_MOD, #0xff ; Use LCD_DATA as output port
    clr LCD_RW ;  Only writing to the LCD in this code.
	
	mov a, #0ch ; Display on command
	lcall command_LCD
	mov a, #38H ; 8-bits interface, 2 lines, 5x7 characters
	lcall command_LCD
	
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------    
; Displays 32 characters on the LCD
;------------------------------------------------     
; REQUIRES/INPUT:
;	line1_LCD (16 bytes)
;	line2_LCD (16 bytes)
; 
; Both are ASCII encoded
;------------------------------------------------        
displayString_LCD:
	mov R0, #32
	mov R1, #80H
	mov dptr, #line1_LCD
displayString_L0_LCD:
	clr A
	movc A, @A+dptr	; Grab next character in string
	mov R2, A
	
	name_LCD( R1, R2 )

	inc R1
	inc dptr
	dec R0
	djnz R0, displayString_L0_LCD
	ret
	
$LIST

