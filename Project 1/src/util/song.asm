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
	mov R7, #25
	
play_L0_song:	
	mov dptr, #VIVALDI_SONG
	lcall getCodeByte_helper
	MOV reload0_timer+0, R0		;higher bits
	inc dptr
	lcall getCodeByte_helper
	MOV reload0_timer+1, R0		;lower bits
	LCALL start0_timer
	
	wait_song(counter_Song)
	
	djnz R7, play_L0_song
	
	ret 
	
wait_song mac
	push dpl
	push dph
	
	mov buzzer_small , #250
	mov dptr, #VIVALDI_DELAY_SONG
	clr c
	mov a, dpl
	add a, #%0
	mov dpl, a
	mov a, dph
	addc a, #0
	mov dph, a
	lcall getCodeByte_helper
	mov buzzer_big , R0
	mov buzzer_temp , buzzer_small
	inc counter_Song
	
	pop dph
	pop dpl
endmac
	
$LIST
