;------------------------------------------------
; constants.asm
;------------------------------------------------
; Constants
;	Define code and global constants here
;------------------------------------------------

$NOLIST
CSEG
;------------------------------------------------
; setup.asm
;------------------------------------------------
MAXSOAKRATE:			DB 5		;*C/s
MINSOAKRATE:			DB 1		;*C/s
MAXSOAKTEMP:			DB 200		;*C
MINSOAKTEMP:			DB 100		;*C
MAXSOAKTIME:			DB 120		;seconds
MINSOAKTIME:			DB 80		;seconds
MAXREFLOWRATE:			DB 5		;*C/s
MINREFLOWRATE:			DB 1		;*C/s
MAXREFLOWTEMP:			DW 300		;*C
MINREFLOWTEMP:			DB 200		;*C
MAXREFLOWTIME:			DB 90		;seconds
MINREFLOWTIME:			DB 30		;seconds
MAXCOOLRATE:			DB 10		;*C/s
MINCOOLRATE:			DB 5		;*C/s

DEFAULT1_SOAKRATE:		DB 3
DEFAULT1_SOAKTEMP:		DB 150
DEFAULT1_SOAKTIME:		DB 1
DEFAULT1_REFLOWRATE:	DB 1
DEFAULT1_REFLOWTEMP:	DB 1
DEFAULT1_REFLOWTIME:	DB 1
DEFAULT1_COOLRATE:		DB 1

$LIST