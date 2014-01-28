;------------------------------------------------
;	Alvin Lao
;------------------------------------------------

$NOLIST
CSEG

;------------------------------------------------
; Configure the serial port and baud rate using timer 2
;------------------------------------------------
InitSerialPort:
	clr TR2 ; Disable timer 2
	mov T2CON, #30H ; RCLK=1, TCLK=1 
	mov RCAP2H, #high(T2LOAD)  
	mov RCAP2L, #low(T2LOAD)
	setb TR2 ; Enable timer 2
	mov SCON, #52H
	ret

;------------------------------------------------
; Send a character through the serial port
; A - Contains character to send
;------------------------------------------------
putchar:
    JNB TI, putchar
    CLR TI
    MOV SBUF, a
    RET

;------------------------------------------------
; Send a constant-zero-terminated string through the serial port
; DPTR - Points to CSEG where target string is
;------------------------------------------------
SendString:
    CLR A
    MOVC A, @A+DPTR
   	JZ SSDone
    LCALL putchar
    INC DPTR
    SJMP SendString
SSDone:
    ret

;------------------------------------------------
; Send one character
; R0 - Contains character
;------------------------------------------------
SendCharacter:
	mov A, R0
    LCALL putchar    
    ret
    
$LIST	