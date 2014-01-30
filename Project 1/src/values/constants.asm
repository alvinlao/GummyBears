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
MAX_SOAKRATE:			DB 5		;*C/s
MIN_SOAKRATE:			DB 1		;*C/s
MAX_SOAKTEMP:			DB 200		;*C
MIN_SOAKTEMP:			DB 100		;*C
MAX_SOAKTIME:			DB 120		;seconds
MIN_SOAKTIME:			DB 80		;seconds
MAX_REFLOWRATE:			DB 5		;*C/s
MIN_REFLOWRATE:			DB 1		;*C/s
MAX_REFLOWTEMP:			DB 235		;*C
MIN_REFLOWTEMP:			DB 200		;*C
MAX_REFLOWTIME:			DB 90		;seconds
MIN_REFLOWTIME:			DB 30		;seconds
MAX_COOLRATE:			DB 10		;*C/s
MIN_COOLRATE:			DB 5		;*C/s

DEFAULT1_SOAKRATE:		DB 3
DEFAULT1_SOAKTEMP:		DB 150
DEFAULT1_SOAKTIME:		DB 1
DEFAULT1_REFLOWRATE:	DB 1
DEFAULT1_REFLOWTEMP:	DB 1
DEFAULT1_REFLOWTIME:	DB 1
DEFAULT1_COOLRATE:		DB 1

$LIST
