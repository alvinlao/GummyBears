;------------------------------------------------
; spi.asm
;------------------------------------------------
; ADC interface
;------------------------------------------------
; Author: Alvin Lao
;------------------------------------------------
$NOLIST

MISO   EQU  P0.0 
MOSI   EQU  P0.1 
SCLK   EQU  P0.2
CE_ADC EQU  P0.3

CSEG

;------------------------------------------------    
; + Public function
;------------------------------------------------
; Initialize ports for spi communication
;------------------------------------------------    
setup_spi:
	setb CE_ADC			  ; Set CS output to 1 (Pause ADC)
    orl P0MOD, #00000110b ; Set SCLK, MOSI as outputs
    anl P0MOD, #11111110b ; Set MISO as input
    clr SCLK              ; For mode (0,0) SCLK is zero
	ret

;------------------------------------------------    
; - Private function
;------------------------------------------------
; INPUT:
; R0 - Byte to write
; R1 - Return byte (ADC)	
;------------------------------------------------
DO_SPI_G_spi:
	push acc
    mov R1, #0            ; Received byte stored in R1
    mov R2, #8            ; Loop counter (8-bits)
DO_SPI_G_LOOP_spi:
    mov a, R0             ; Byte to write is in R0
    rlc a                 ; Carry flag has bit to write
    mov R0, a
    mov MOSI, c
    setb SCLK             ; Transmit
    mov c, MISO           ; Read received bit
    mov a, R1             ; Save received bit in R1
    rlc a
    mov R1, a
    clr SCLK
    djnz R2, DO_SPI_G_LOOP_spi
    pop acc
    ret
   
;------------------------------------------------    
; + Public function
;------------------------------------------------   
; INPUT:
; B - Channel to read passed (0, 1, 2, 3)
;------------------------------------------------    
; OUTPUT:
; R7 - Bits 8 & 9 (#xxxx xx??)
; R6 - Bits 0 - 7 (#???? ????)
;------------------------------------------------    
Read_ADC_Channel_spi:
	clr CE_ADC
	mov R0, #00000001B ; Start bit:1
	lcall DO_SPI_G_spi
	
	mov a, b
	swap a
	anl a, #0F0H
	setb acc.7 ; Single mode (bit 7).
	
	mov R0, a ;  Select channel
	lcall DO_SPI_G_spi
	mov a, R1
	anl a, #03H
	mov R7, a			; R7 contains bits 8 and 9
	
	mov R0, #55H ; It doesn't matter what we transmit...
	lcall DO_SPI_G_spi
	mov a, R1
	mov R6, a			; R6 contains bits 0 to 7
	setb CE_ADC
	ret
	
$LIST
