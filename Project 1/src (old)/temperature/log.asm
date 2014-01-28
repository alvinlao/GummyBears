;------------------------------------------------
;	Alvin Lao
;------------------------------------------------

$NOLIST
CSEG

;------------------------------------------------
; Send temperature through serial port
; R0 - Temperature
;------------------------------------------------
logTemperature:
	lcall sendCharacter
	ret
	
$LIST