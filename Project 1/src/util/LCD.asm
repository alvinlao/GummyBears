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
	mov a , %0 
	lcall command_LCD

	mov a , %1
	lcall put_LCD
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
; void setup_LCD ( void )
; Must be called before using other LCD functions
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
; void displayString_LCD( void )
; Displays 32 characters on the LCD
;------------------------------------------------     
; REQUIRES/INPUT:
;	string_LCD (32 bytes)
; 
; Both are ASCII encoded
;------------------------------------------------        
displayString_LCD:
	mov R7, #32
	mov R1, #80H
	mov dptr, #string_LCD
displayString_L0_LCD:	
	lcall getCodeByte_helper	; Grab next character in string
	name_LCD( R1, R0 )
	
	inc R1
	inc dptr
	dec R7
	djnz R7, displayString_L0_LCD
	ret

;------------------------------------------------    
; + Public function
;------------------------------------------------    
; void loadString_LCD( dptr )
; Moves a string to string_LCD
;------------------------------------------------     
; INPUT:
;	dptr - Points to the string to be loaded
;------------------------------------------------        
loadString_LCD:
	clr A
	movc A, @A+dptr
	mov string_LCD, A
	inc dptr
	clr A
	movc A, @A+dptr
	mov string_LCD+1, A
	ret
	
$LIST