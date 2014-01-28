;------------------------------------------------
;	Alvin Lao
;------------------------------------------------

$NOLIST

CSEG

;------------------------------------------------
; volt[R0, R1] convertBinToVoltage(bin [R0, R1])
;
; Converts the K-type thermocouple voltage to microvolts
; (!) Assumes K-type signal is gain x500
;------------------------------------------------
convertBinToVoltage:
	mov x, R1
	mov x+1, R0
	mov y, #10		;volt = 9.92 * x
	mov y+1, #0
	lcall mul16
	mov R0, x+1
	mov R1, x
	ret
	
;------------------------------------------------
; void updateInputVoltages(void)
;
; updates global vars: ovenVoltage & coldVoltage
;------------------------------------------------
updateInputVoltages:
	mov b, #0  ; Read channel 0 (LM335)
	lcall Read_ADC_Channel
	mov coldVoltage, R7
	mov coldVoltage+1, R6
	
	mov b, #1  ; Read channel 1 (Thermocouple)
	lcall Read_ADC_Channel

	mov ovenVoltage, R7
	mov ovenVoltage+1, R6
	ret

;------------------------------------------------	
; temp[R0] getOvenTemp(coldVoltage [R0, R1], ovenVoltage[R2, R3])	
;------------------------------------------------
getOvenTemp:
	; Prepare K-type thermocouple voltage
	;mov y+1, R2
	;mov y, R3
	push ar0
	push ar1
	
	mov A, R2
	mov R0, A
	mov A, R3
	mov R1, A
	lcall convertBinToVoltage
	
	mov y+1, R0
	mov y, R1
	
	pop ar1
	pop ar0
	
	;Convert LM335 voltage to LUT voltage
	lcall findLM335Tempurature		;temp [R0] lm335getTemp(volt [R0, R1])	
	lcall findVoltage				;volt [R0, R1] findVoltage(temp [R0])
	
	;sum[c, R0, R1] add16(x[R0, R1], y[R2, R3])
	mov x+1, R0
	mov x, R1
	lcall add16 ;(LM335 converted voltage) + (oven voltage) 	
	mov R0, x+1
	mov R1, x
	
	;Final conversion to temperature
	lcall findTemperature
	ret
	
$LIST