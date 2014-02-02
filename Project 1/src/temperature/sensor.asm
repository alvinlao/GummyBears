;------------------------------------------------
; sensor.asm
;------------------------------------------------
; Sensor for oven temperature 
;------------------------------------------------
; DEPENDENCIES:
;	lm335.asm
;	lookup.asm
; 	../spi.asm
;	../util/math16.asm
;------------------------------------------------
; Author: Alvin Lao
;------------------------------------------------

$NOLIST
	
CSEG

;------------------------------------------------
; - Private function
;------------------------------------------------
; volt[R0, R1] convertBinToVoltage(bin [ovenVoltage, ovenVoltage+1])
; Converts the K-type thermocouple voltage to microvolts
;------------------------------------------------
; (!) Assumes K-type signal is gain x500
;------------------------------------------------
ovenBin2Voltage_sensor:
	mov x, ovenVoltage+1
	mov x+1, ovenVoltage
	mov y, #10		;volt = 9.92 * x
	mov y+1, #0
	lcall mul16
	mov R0, x+1
	mov R1, x
	ret

;------------------------------------------------
; - Private function	
;------------------------------------------------
; void updateInputVoltages( void )
; updates global vars: ovenVoltage & coldVoltage
;------------------------------------------------
updateInputVoltages_sensor:
	mov b, #0  ; Read channel 0 (LM335)
	lcall Read_ADC_Channel_spi

	mov coldVoltage, R7
	mov coldVoltage+1, R6
	
	mov b, #1  ; Read channel 1 (Thermocouple)
	lcall Read_ADC_Channel_spi
	mov ovenVoltage, R7
	mov ovenVoltage+1, R6
	
	ret

;------------------------------------------------
; + Public function	
;------------------------------------------------	
; temp[R0] & temp[currentTemp, currentTemp+1] getOvenTemp( void )
;------------------------------------------------	
; REQUIRES:
;	coldVoltage (2 bytes)
;	ovenVoltage (2 bytes)
;------------------------------------------------	
; OUTPUT:
; 	R0 - The temperature at the hot junction of thermocouple
;------------------------------------------------
getOvenTemp_sensor:
	; Update ovenVoltage and coldVoltage
	lcall updateInputVoltages_sensor

	; Prepare K-type thermocouple voltage
	lcall ovenBin2Voltage_sensor
	mov y+1, R0
	mov y, R1
	
	; Convert LM335 voltage to LUT voltage
	mov R0, coldVoltage
	mov R1, coldVoltage+1
	lcall findLM335Tempurature_lm335		;temp [R0] lm335getTemp(volt [R0, R1])	
	lcall findVoltage_lookup				;volt [R0, R1] findVoltage(temp [R0])
	
	; Real thermocouple voltage = (LM335 converted voltage) + (oven voltage)	
	mov x+1, R0
	mov x, R1
	lcall add16
	mov R0, x+1
	mov R1, x
	
	; Convert voltage to temperature
	lcall findTemperature_lookup
	mov currentTemp, R0
	ret
	
$LIST
