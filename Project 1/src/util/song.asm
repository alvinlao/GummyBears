;------------------------------------------------
; song.asm
;------------------------------------------------
; Provides song
;------------------------------------------------
; DEPENDENCIES:
; 	helper.asm
;	timer.asm
; NOTE: 
;	Requires timer 0
;------------------------------------------------
; Author: 
;------------------------------------------------

$NOLIST
CSEG
	counter_Song: 	DB 0
play_song:
	mov dptr, #VIVALDI_SONG
	lcall getCodeByte_helper
	MOV reload0_timer+1, R0
	inc dptr
	lcall getCodeByte_helper
	MOV reload0_timer+0, R0
	LCALL start0_timer
	
	LCALL wait_song
wait_song:
	
$LIST
