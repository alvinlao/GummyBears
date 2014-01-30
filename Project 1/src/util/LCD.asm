$NOLIST
CSEG

name MAC 

mov a , %0 
lcall LCD_command

mov a , %1
lcall LCD_put

ENDMAC


Wait40us:
	mov R0, #149
X1: 
	nop
	nop
	nop
	nop
	nop
	nop
	djnz R0, X1 ; 9 machine cycles-> 9*30ns*149=40us
    ret

LCD_command:
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
	ljmp Wait40us

LCD_put:
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
	ljmp Wait40us
	    
LCD_InitLCD:    
    ; Turn LCD on, and wait a bit.
    setb LCD_ON
    clr LCD_EN  ; Default state of enable must be zero
    lcall Wait40us
    
    mov LCD_MOD, #0xff ; Use LCD_DATA as output port
    clr LCD_RW ;  Only writing to the LCD in this code.
	
	mov a, #0ch ; Display on command
	lcall LCD_command
	mov a, #38H ; 8-bits interface, 2 lines, 5x7 characters
	lcall LCD_command

ret

LCD_SetProfile:

    name( #80H , #' ' ) 
    name( #81H , #' ' ) 
    name( #82H , #' ' ) 
    name( #83H , #' ' ) 
    name( #84H , #' ' ) 
    name( #85H , #' ' ) 
    name( #86H , #'S' ) 
    name( #87H , #'E' ) 
    name( #88H , #'T' ) 
    name( #89H , #' ' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #' ' ) 
    name( #8CH , #' ' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #'P' )
    name( #0C4H , #'R' ) 
    name( #0C5H , #'O' ) 
    name( #0C6H , #'F' ) 
    name( #0C7H , #'I' ) 
    name( #0C8H , #'L' ) 
    name( #0C9H , #'E' ) 
    name( #0CAH , #'.' )
    name( #0CBH , #'.' ) 
    name( #0CCH , #'.' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 

ret

LCD_SetReflowRate:

    name( #80H , #'S' ) 
    name( #81H , #'e' ) 
    name( #82H , #'t' ) 
    name( #83H , #' ' ) 
    name( #84H , #'R' ) 
    name( #85H , #'e' ) 
    name( #86H , #'f' ) 
    name( #87H , #'l' ) 
    name( #88H , #'o' ) 
    name( #89H , #'w' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #'R' ) 
    name( #8CH , #'a' ) 
    name( #8DH , #'t' ) 
    name( #8EH , #'e' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 

ret

LCD_SetReflowTime:

    name( #80H , #'S' ) 
    name( #81H , #'e' ) 
    name( #82H , #'t' ) 
    name( #83H , #' ' ) 
    name( #84H , #'R' ) 
    name( #85H , #'e' ) 
    name( #86H , #'f' ) 
    name( #87H , #'l' ) 
    name( #88H , #'o' ) 
    name( #89H , #'w' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #'T' ) 
    name( #8CH , #'i' ) 
    name( #8DH , #'m' ) 
    name( #8EH , #'e' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 

ret

LCD_SetReflowTemperature:

    name( #80H , #'S' ) 
    name( #81H , #'e' ) 
    name( #82H , #'t' ) 
    name( #83H , #' ' ) 
    name( #84H , #'R' ) 
    name( #85H , #'e' ) 
    name( #86H , #'f' ) 
    name( #87H , #'l' ) 
    name( #88H , #'o' ) 
    name( #89H , #'w' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #' ' ) 
    name( #8CH , #' ' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #'T' ) 
    name( #0C1H , #'e' )
    name( #0C2H , #'m' ) 
    name( #0C3H , #'p' )
    name( #0C4H , #'e' ) 
    name( #0C5H , #'r' ) 
    name( #0C6H , #'a' ) 
    name( #0C7H , #'t' ) 
    name( #0C8H , #'u' ) 
    name( #0C9H , #'r' ) 
    name( #0CAH , #'e' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 
  
ret

LCD_SetSoakRate:

    name( #80H , #'S' ) 
    name( #81H , #'e' ) 
    name( #82H , #'t' ) 
    name( #83H , #' ' ) 
    name( #84H , #'S' ) 
    name( #85H , #'o' ) 
    name( #86H , #'a' ) 
    name( #87H , #'k' ) 
    name( #88H , #' ' ) 
    name( #89H , #'R' ) 
    name( #8AH , #'a' ) 
    name( #8BH , #'t' ) 
    name( #8CH , #'e' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 

ret

LCD_CoolRate:

    name( #80H , #' ' ) 
    name( #81H , #' ' ) 
    name( #82H , #' ' ) 
    name( #83H , #'C' ) 
    name( #84H , #'o' ) 
    name( #85H , #'o' ) 
    name( #86H , #'l' ) 
    name( #87H , #' ' ) 
    name( #88H , #' ' ) 
    name( #89H , #'R' ) 
    name( #8AH , #'a' ) 
    name( #8BH , #'t' ) 
    name( #8CH , #'e' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 

ret

LCD_SetSoakTime:

    name( #80H , #'S' ) 
    name( #81H , #'e' ) 
    name( #82H , #'t' ) 
    name( #83H , #' ' ) 
    name( #84H , #'S' ) 
    name( #85H , #'o' ) 
    name( #86H , #'a' ) 
    name( #87H , #'k' ) 
    name( #88H , #' ' ) 
    name( #89H , #'T' ) 
    name( #8AH , #'i' ) 
    name( #8BH , #'m' ) 
    name( #8CH , #'e' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 

ret

LCD_SetSoakTemperature:

    name( #80H , #'S' ) 
    name( #81H , #'e' ) 
    name( #82H , #'t' ) 
    name( #83H , #' ' ) 
    name( #84H , #'S' ) 
    name( #85H , #'o' ) 
    name( #86H , #'a' ) 
    name( #87H , #'k' ) 
    name( #88H , #' ' ) 
    name( #89H , #' ' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #' ' ) 
    name( #8CH , #' ' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #'T' ) 
    name( #0C1H , #'e' )
    name( #0C2H , #'m' ) 
    name( #0C3H , #'p' )
    name( #0C4H , #'e' ) 
    name( #0C5H , #'r' ) 
    name( #0C6H , #'a' ) 
    name( #0C7H , #'t' ) 
    name( #0C8H , #'u' ) 
    name( #0C9H , #'r' ) 
    name( #0CAH , #'e' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 
  
ret

LCD_Soak:

    name( #80H , #'S' ) 
    name( #81H , #'o' ) 
    name( #82H , #'a' ) 
    name( #83H , #'k' ) 
    name( #84H , #' ' ) 
    name( #85H , #' ' ) 
    name( #86H , #' ' ) 
    name( #87H , #' ' ) 
    name( #88H , #' ' ) 
    name( #89H , #' ' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #' ' ) 
    name( #8CH , #' ' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 
  
ret

LCD_Reflow:

    name( #80H , #'R' ) 
    name( #81H , #'e' ) 
    name( #82H , #'f' ) 
    name( #83H , #'l' ) 
    name( #84H , #'o' ) 
    name( #85H , #'w' ) 
    name( #86H , #' ' ) 
    name( #87H , #' ' ) 
    name( #88H , #' ' ) 
    name( #89H , #' ' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #' ' ) 
    name( #8CH , #' ' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 
  
ret

LCD_Cooldown:

    name( #80H , #'C' ) 
    name( #81H , #'o' ) 
    name( #82H , #'o' ) 
    name( #83H , #'l' ) 
    name( #84H , #'d' ) 
    name( #85H , #'o' ) 
    name( #86H , #'w' ) 
    name( #87H , #'n' ) 
    name( #88H , #' ' ) 
    name( #89H , #' ' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #' ' ) 
    name( #8CH , #' ' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 
  
ret

LCD_PreheatSoak:

    name( #80H , #'H' ) 
    name( #81H , #'e' ) 
    name( #82H , #'a' ) 
    name( #83H , #'t' ) 
    name( #84H , #'i' ) 
    name( #85H , #'n' ) 
    name( #86H , #'g' ) 
    name( #87H , #' ' ) 
    name( #88H , #'t' ) 
    name( #89H , #'o' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #'S' ) 
    name( #8CH , #'o' ) 
    name( #8DH , #'a' ) 
    name( #8EH , #'k' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 
  
ret

LCD_PreheatReflow:

    name( #80H , #'H' ) 
    name( #81H , #'e' ) 
    name( #82H , #'a' ) 
    name( #83H , #'t' ) 
    name( #84H , #'i' ) 
    name( #85H , #'n' ) 
    name( #86H , #'g' ) 
    name( #87H , #' ' ) 
    name( #88H , #'t' ) 
    name( #89H , #'o' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #' ' ) 
    name( #8CH , #' ' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #'R' ) 
    name( #0C1H , #'e' )
    name( #0C2H , #'f' ) 
    name( #0C3H , #'l' )
    name( #0C4H , #'o' ) 
    name( #0C5H , #'w' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 
  
ret

LCD_STOPPED:

    name( #80H , #'S' ) 
    name( #81H , #'T' ) 
    name( #82H , #'O' ) 
    name( #83H , #'P' ) 
    name( #84H , #'P' ) 
    name( #85H , #'E' ) 
    name( #86H , #'D' ) 
    name( #87H , #'.' ) 
    name( #88H , #'.' ) 
    name( #89H , #'.' ) 
    name( #8AH , #' ' ) 
    name( #8BH , #' ' ) 
    name( #8CH , #' ' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 
  
ret

LCD_FINISHED:

    name( #80H , #'F' ) 
    name( #81H , #'I' ) 
    name( #82H , #'N' ) 
    name( #83H , #'I' ) 
    name( #84H , #'S' ) 
    name( #85H , #'H' ) 
    name( #86H , #'E' ) 
    name( #87H , #'D' ) 
    name( #88H , #'.' ) 
    name( #89H , #'.' ) 
    name( #8AH , #'.' ) 
    name( #8BH , #' ' ) 
    name( #8CH , #' ' ) 
    name( #8DH , #' ' ) 
    name( #8EH , #' ' ) 
    name( #8FH , #' ' ) 
    name( #0C0H , #' ' ) 
    name( #0C1H , #' ' )
    name( #0C2H , #' ' ) 
    name( #0C3H , #' ' )
    name( #0C4H , #' ' ) 
    name( #0C5H , #' ' ) 
    name( #0C6H , #' ' ) 
    name( #0C7H , #' ' ) 
    name( #0C8H , #' ' ) 
    name( #0C9H , #' ' ) 
    name( #0CAH , #' ' )
    name( #0CBH , #' ' ) 
    name( #0CCH , #' ' ) 
    name( #0CDH , #' ' ) 
    name( #0CEH , #' ' )  
    name( #0CFH , #' ' ) 
  
ret

$LIST

