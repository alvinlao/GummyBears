;------------------------------------------------
; constants.asm
;------------------------------------------------
; Constants
;	Define code and global constants here
;------------------------------------------------

$NOLIST
CSEG
;-------------------------------------------------
;Buzzer Song
;-------------------------------------------------
;VIVALDI_SONG:			DB 
;VIVALDI_DELAY_SONG:	DB

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
MAX_REFLOWTEMP:			DB 225		;*C
MIN_REFLOWTEMP:			DB 200		;*C
MAX_REFLOWTIME:			DB 90		;seconds
MIN_REFLOWTIME:			DB 30		;seconds
MAX_COOLRATE:			DB 10		;*C/s
MIN_COOLRATE:			DB 5		;*C/s

FINISH_TEMP:			DB 27		;*C/s

DEFAULT1_SOAKRATE:		DB 1
DEFAULT1_SOAKTEMP:		DB 170
DEFAULT1_SOAKTIME:		DB 100
DEFAULT1_REFLOWRATE:		DB 3
DEFAULT1_REFLOWTEMP:		DB 220
DEFAULT1_REFLOWTIME:		DB 40
DEFAULT1_COOLRATE:		DB 6

DEFAULT2_SOAKRATE:		DB 1
DEFAULT2_SOAKTEMP:		DB 150
DEFAULT2_SOAKTIME:		DB 110
DEFAULT2_REFLOWRATE:		DB 2
DEFAULT2_REFLOWTEMP:		DB 220
DEFAULT2_REFLOWTIME:		DB 50
DEFAULT2_COOLRATE:		DB 2

DEFAULT3_SOAKRATE:		DB 1
DEFAULT3_SOAKTEMP:		DB 150
DEFAULT3_SOAKTIME:		DB 90
DEFAULT3_REFLOWRATE:		DB 3
DEFAULT3_REFLOWTEMP:		DB 220
DEFAULT3_REFLOWTIME:		DB 45
DEFAULT3_COOLRATE:		DB 3

$LIST
