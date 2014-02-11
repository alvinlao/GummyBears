$NOLIST

CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void update_live( void )
; Display on the altera board:
; 	1) Current temperature takes 2 bytes is displayed in upper 4 hex display
;	2) Running time takes 1 byte is displayed in lower 3 hex display
;	3) Current reflow process will see what value is in the state value and show things for that state.
;------------------------------------------------
update_live:
	mov dptr , #sevenSegLUT

	;Time

	mov a , runTime
	mov b,#100
	div ab
	mov a , b
	mov b,#10
	div ab
	movc a , @a+dptr
	mov HEX5 , a
	mov a , b 
	movc a , @a+dptr
	mov HEX4 , a


	mov a , runTime+1
	mov b,#100
	div ab
	mov a , b
	mov b,#10
	div ab
	movc a , @a+dptr
	mov HEX7 , a
	mov a , b 
	movc a , @a+dptr
	mov HEX6 , a

	;Tempurature
	jnb SWA.0, celsius_live
fahrenheit_live:
	; (currentTemp * 9/5) + 32
	mov x, currentTemp
	mov x+1, #0
	mov y, #9
	mov y+1, #0
	lcall mul16
	mov y, #5
	mov y+1, #0
	lcall div16
	mov y, #32
	mov y+1, #0
	lcall add16
	lcall hex2bcd
	
	;Display
    mov A, BCD+1
    anl A, #0FH
    movc A, @A+dptr
	mov HEX2, A
    
	mov A, BCD
    swap A
    anl A, #0FH
    movc A, @A+dptr
	mov HEX1, A
	
    mov A, BCD
    anl A, #0FH
    movc A, @A+dptr
    mov HEX0, A
    	
	sjmp displayState_live
	
celsius_live:
	mov a , currentTemp
	mov b,#100
	div ab
	movc a , @a+dptr
	mov HEX2, a
	mov a , b
	mov B,#10
	div ab
	movc a , @a+dptr
	mov HEX1 , a
	mov a , b 
	movc a , @a+dptr
	mov HEX0 , a

displayState_live:
	;State decision only goes up to three different states right now.
	
	jnb SWA.1, overall_live
progress_bar_live:
	clr c
Zero_progress_live:
	mov a , currentState
	subb a , #1 
	jnc One_progress_live
	ljmp Done_live
One_progress_live: 
	mov a , currentState
	subb a , #2 
	jnc Two_progress_live
	mov dptr , #PROGRESS_0_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
Two_progress_live: 
	mov a , currentState
	subb a , #3 
	jnc Three_progress_live
	mov dptr , #PROGRESS_25_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
Three_progress_live:
	mov a , currentState
	subb a , #4
	jnc Four_progress_live
	mov dptr , #PROGRESS_50_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
Four_progress_live: 
	mov a , currentState
	subb a , #5 
	jnc Five_progress_live
	mov dptr , #PROGRESS_50_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
Five_progress_live: 
	mov a , currentState
	subb a , #6 
	jnc Six_progress_live
	mov dptr , #PROGRESS_75_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
Six_progress_live: 
	mov a , currentState
	mov dptr , #PROGRESS_100_STRINGS
	lcall displayStringFromCode_LCD
	ret
overall_live:
	clr c
	Zero_live:
	mov a , currentState
	subb a , #1 
	jnc One_live
	ljmp Done_live
	One_live: 
	mov a , currentState
	subb a , #2 
	jnc Two_live
	mov dptr , #PREHEATSOAK_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
	Two_live: 
	mov a , currentState
	subb a , #3 
	jnc Three_live
	mov dptr , #SOAK_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
	Three_live:
	mov a , currentState
	subb a , #4
	jnc Four_live
	mov dptr , #PREHEATREFLOW_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
	Four_live: 
	mov a , currentState
	subb a , #5 
	jnc Five_live
	mov dptr , #REFLOW_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
	Five_live: 
	mov a , currentState
	subb a , #6 
	jnc Six_live
	mov dptr , #COOLDOWN_STRINGS
	lcall displayStringFromCode_LCD
	ljmp Done_live
	Six_live: 
	mov a , currentState
	mov dptr , #FINISHED_STRINGS
	lcall displayStringFromCode_LCD
	orl P3MOD , #00000011B
	setb P3.0
	setb P3.1
	mov flagTemp+2, #40
Flag3: mov flagTemp+1, #250
Flag2: mov flagTemp+0, #250
Flag1: djnz flagTemp+0, Flag1 ; machine cycles -> 3*30ns*250 = 22.5us
	djnz flagTemp+1, Flag2 ; 22.5us*250=5.625ms
	djnz flagTemp+2, Flag3 ; 5.625ms*50.0 = around 0.5s
	clr P3.0
Done_live:
	ret


$LIST