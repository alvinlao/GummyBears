;------------------------------------------------
; constants.asm
;------------------------------------------------
; Constants
;------------------------------------------------

;------------------------------------------------
;spi.asm
;------------------------------------------------
MISO   EQU  P0.0 
MOSI   EQU  P0.1 
SCLK   EQU  P0.2
CE_ADC EQU  P0.3

FREQ   EQU 33333333
BAUD   EQU 115200
T2LOAD EQU 65536-(FREQ/(32*BAUD))

;------------------------------------------------
;setup.asm
;------------------------------------------------
MAXSOAKRATE		EQU 5		;*C/s
MINSOAKRATE		EQU 1		;*C/s
MAXSOAKTEMP		EQU 200		;*C
MINSOAKTEMP		EQU 100		;*C
MAXSOAKTIME		EQU 120		;seconds
MINSOAKTIME		EQU 80		;seconds
MAXREFLOWRATE	EQU 5		;*C/s
MINREFLOWRATE	EQU 1		;*C/s
MAXREFLOWTEMP	EQU	300		;*C
MINREFLOWTEMP	EQU 200		;*C
MAXREFLOWTIME	EQU 90		;seconds
MINREFLOWTIME	EQU 30		;seconds
MAXCOOLRATE		EQU 10		;*C/s
MINCOOLRATE		EQU 5		;*C/s

DEFAULT1_SOAKRATE		EQU 3
DEFAULT1_SOAKTEMP		EQU 150
DEFAULT1_SOAKTIME		EQU 1
DEFAULT1_REFLOWRATE		EQU 1
DEFAULT1_REFLOWTEMP		EQU 1
DEFAULT1_REFLOWTIME		EQU 1
DEFAULT1_COOLRATE		EQU 1