;------------------------------------------------
; serial.asm
;------------------------------------------------
; Used to send information through the serial port
;------------------------------------------------
; Author: Alvin Lao
;------------------------------------------------

$NOLIST
CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup_serial( void )
; Setup serial ports and timer 2 for baud rate generation
;------------------------------------------------
setup_serial:
	clr TR2 ; Disable timer 2
	mov T2CON, #30H ; RCLK=1, TCLK=1 
	mov RCAP2H, #high(T2LOAD)  
	mov RCAP2L, #low(T2LOAD)
	setb TR2 ; Enable timer 2
	mov SCON, #52H
	ret

;------------------------------------------------    
; - Private function
;------------------------------------------------
; Send a character through the serial port
;------------------------------------------------v
; INPUT:
; A - Contains character to send
;------------------------------------------------
putchar_serial:
    JNB TI, putchar_serial
    CLR TI
    MOV SBUF, a
    RET

;------------------------------------------------    
; + Public function
;------------------------------------------------
; Send a constant-zero-terminated string through the serial port
;------------------------------------------------
; INPUT:
; DPTR - Points to CSEG where target string is
;------------------------------------------------
SendString_serial:
    CLR A
    MOVC A, @A+DPTR
   	JZ SSDone_serial
    LCALL putchar_serial
    INC DPTR
    SJMP SendString_serial
SSDone_serial:
    ret
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void sendByte_serial( character [R0] )
; Send a byte through the serial port
;------------------------------------------------
; INPUT:
; 	character - A byte ASCII encoded
;------------------------------------------------
sendByte_serial:
	mov A, R0
    lcall putchar_serial 
    ret
    
$LIST	