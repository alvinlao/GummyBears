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

	;State decision only goes up to three different states right now.
	clr c

	Zero_live:
	mov a , currentState
	subb a , #1 
	jnc One_live
	mov LEDRA , #00000000B
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
	subb a , #7 
	jnc Seven_live
	mov dptr , #FINISHED_STRINGS
	lcall displayStringFromCode_LCD
Done_live:
	ret


$LIST