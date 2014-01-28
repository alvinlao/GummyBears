;------------------------------------------------
; driver.asm
;------------------------------------------------
; Author: Bibek Kaur
;------------------------------------------------

$NOLIST
CSEG
	;CSEG at 0
	;ljmp VoltageControlSignal
Temp2AV:
	DB	39
	DB	40
	DB	40
	DB	41
	DB	41
	DB	42
	DB	43
	DB	43
	DB	44
	DB	44
	DB	45
	DB	46
	DB	46
	DB	47
	DB	47
	DB	48
	DB	49
	DB	49
	DB	50
	DB	50
	DB	51
	DB	51
	DB	52
	DB	53
	DB	53
	DB	54
	DB	54
	DB	55
	DB	56
	DB	56
	DB	57
	DB	57
	DB	58
	DB	59
	DB	59
	DB	60
	DB	60
	DB	61
	DB	61
	DB	62
	DB	63
	DB	63
	DB	64
	DB	64
	DB	65
	DB	66
	DB	66
	DB	67
	DB	67
	DB	68
	DB	68
	DB	69
	DB	70
	DB	70
	DB	71
	DB	71
	DB	72
	DB	73
	DB	73
	DB	74
	DB	74
	DB	75
	DB	76
	DB	76
	DB	77
	DB	77
	DB	78
	DB	78
	DB	79
	DB	80
	DB	80
	DB	81
	DB	81
	DB	82
	DB	83
	DB	83
	DB	84
	DB	84
	DB	85
	DB	86
	DB	86
	DB	87
	DB	87
	DB	88
	DB	88
	DB	89
	DB	90
	DB	90
	DB	91
	DB	91
	DB	92
	DB	93
	DB	93
	DB	94
	DB	94
	DB	95
	DB	96
	DB	96
	DB	97
	DB	97
	DB	98
	DB	98
	DB	99
	DB	100
	DB	100
	DB	101
	DB	101
	DB	102
	DB	103
	DB	103
	DB	104
	DB	104
	DB	105
	DB	105
	DB	106
	DB	107
	DB	107
	DB	108
	DB	108
	DB	109
	DB	110
	DB	110
	DB	111
	DB	111
	DB	112
	DB	113
	DB	113
	DB	114
	DB	114
	DB	115
	DB	115
	DB	116
	DB	117
	DB	117
	DB	118
	DB	118
	DB	119
	DB	120
	DB	120
	DB	121
	DB	121
	DB	122
	DB	123
	DB	123
	DB	124
	DB	124
	DB	125
	DB	125
	DB	126
	DB	127
	DB	127
	DB	128
	DB	128
	DB	129
	DB	130
	DB	130
	DB	131
	DB	131
	DB	132
	DB	133
	DB	133
	DB	134
	DB	134
	DB	135
	DB	135
	DB	136
	DB	137
	DB	137
	DB	138
	DB	138
	DB	139
	DB	140
	DB	140
	DB	141
	DB	141
	DB	142
	DB	142
	DB	143
	DB	144
	DB	144
	DB	145
	DB	145
	DB	146
	DB	147
	DB	147
	DB	148
	DB	148
	DB	149
	DB	150
	DB	150
	DB	151
	DB	151
	DB	152
	DB	152
	DB	153
	DB	154
	DB	154
	DB	155
	DB	155
	DB	156
	DB	157
	DB	157
	DB	158
	DB	158
	DB	159
	DB	160
	DB	160
	DB	161
	DB	161
	DB	162
	DB	162
	DB	163
	DB	164
	DB	164
	DB	165
	DB	165
	DB	166
	DB	167
	DB	167
	DB	168
	DB	168
	DB	169
	DB	170
	DB	170
	DB	171
	DB	171
	DB	172
	DB	172
	DB	173
	DB	174
	DB	174
	DB	175
	DB	175
	DB	176
	DB	177
	DB	177
	DB	178
	DB	178
	DB	179
	DB	179
	DB	180
	DB	181
	DB	181
	DB	182
	DB	182
	DB	183
	DB	184
	DB	184
	DB	185
	DB	185
	DB	186


;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setup_driver( void )
; Setup the ports
;------------------------------------------------
setup_driver:
	ret
	
	
;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setTemp_driver( temperature [R0] )
; Sets the oven temperature to the desired value
;------------------------------------------------
; INPUT:
; 	R0 - Contains the desired temperature in celsius (0 - 255)
;------------------------------------------------
setTemp_driver:
	ret
	

;------------------------------------------------    
; + Public function
;------------------------------------------------
; void setRamp_driver( ramp rate [R0] )
; Sets the desired ramp rate
;------------------------------------------------
; INPUT:
; 	R0 - Contains the desired ramp rate (*C/s)
;------------------------------------------------
setramp_driver:
	ret

;------------------------------------------------
; - Private function
;------------------------------------------------
VoltageControlSignal_oven:
	mov P1MOD, #0FFH 	;Make all P1 output
	;mov R0, #4
	Mov DPTR , #Temp2AV
	clr c
	mov a, dpl
	add a, R0	;Received temperature in R0
	mov dpl, a
	
	mov a, dph
	addc a, #0
	mov dph, a
	clr a
	movc a, @a+dptr
	mov P1, a	;Submit Digital Voltage to P1
	
	ret
	
$LIST	