;------------------------------------------------
; lookup.asm
;------------------------------------------------
; K-type thermocouple lookup table
; <key, value> => <temperature (0 - 255), voltage (microvolts)>
;------------------------------------------------
; David
;------------------------------------------------

$NOLIST
CSEG

TemptoVoltage:
dw 0000 ;0
dw 0039
dw 0079
dw 0119
dw 0158
dw 0198 ;5
dw 0238
dw 100010101B
dw 0317
dw 0357
dw 0397 ;10
dw 0437 
dw 0477 
dw 0517 
dw 0557
dw 0597 ;15
dw 0637 
dw 0677
dw 0718
dw 0758
dw 0798 ;20
dw 0838
dw 0879
dw 0919
dw 0960
dw 1000 ;25
dw 1041 
dw 1081 
dw 1122
dw 1163
dw 1244 ;30
dw 1285
dw 1326
dw 1366
dw 1407
dw 1448 ;35
dw 1489 
dw 1530
dw 1571
dw 1612
dw 1653 ;40
dw 1694
dw 1735
dw 1776
dw 1817
dw 1858
dw 1899
dw 1941
dw 1982
dw 2064 
dw 2106
dw 2147
dw 2188
dw 2230
dw 2271
dw 2312
dw 2354
dw 2395 
dw 2436
dw 2478
dw 2519
dw 2561
dw 2602
dw 2644
dw 2685
dw 2727
dw 2768
dw 2810
dw 2851
dw 2893
dw 2934
dw 2976
dw 3017
dw 3059
dw 3100
dw 3142
dw 3184
dw 3225
dw 3267
dw 3308
dw 3350
dw 3391
dw 3433
dw 3474
dw 3516
dw 3557
dw 3599
dw 3640
dw 3682
dw 3723
dw 3765
dw 3806
dw 3848
dw 3889
dw 3931
dw 3972
dw 4013
dw 4055 
dw 4096
dw 4138
dw 4179
dw 4220
dw 4262
dw 4303
dw 4344
dw 4385
dw 4427
dw 4468
dw 4509
dw 4550
dw 4591
dw 4633
dw 4674
dw 4715
dw 4756
dw 4797
dw 4838
dw 4879
dw 4920
dw 4961
dw 5002
dw 5043
dw 5084
dw 5124
dw 5165
dw 5206
dw 5247
dw 5288
dw 5328
dw 5369
dw 5410
dw 5450
dw 5491
dw 5532
dw 5613
dw 5653
dw 5694
dw 5735
dw 5735
dw 5775
dw 5815
dw 5856
dw 5896
dw 5937
dw 5977
dw 6017
dw 6058
dw 6098 
dw 6138
dw 6179
dw 6219
dw 6259
dw 6299
dw 6339
dw 6380
dw 6420
dw 6460
dw 6500 
dw 6540
dw 6580
dw 6620
dw 6660
dw 6701
dw 6741
dw 6781
dw 6821
dw 6861
dw 6901
dw 6941
dw 6981
dw 7021
dw 7060
dw 7100
dw 7140
dw 7180
dw 7220
dw 7260
dw 7300
dw 7340 
dw 7380
dw 7420
dw 7460
dw 7500
dw 7540
dw 7579
dw 7619
dw 7659
dw 7699
dw 7739
dw 7779
dw 7819
dw 7859
dw 7899
dw 7939
dw 7979
dw 8019
dw 8059
dw 8099
dw 8138 
dw 8178
dw 8218
dw 8258
dw 8298
dw 8338
dw 8378
dw 8418
dw 8458
dw 8499
dw 8539 
dw 8579
dw 8619
dw 8659
dw 8699
dw 8739
dw 8779
dw 8819
dw 8860
dw 8900
dw 8940
dw 8980
dw 9020
dw 9061
dw 9101
dw 9141
dw 9181
dw 9222
dw 9262
dw 9302
dw 9343 
dw 9383
dw 9423
dw 9464
dw 9504
dw 9545
dw 9585
dw 9626
dw 9666
dw 9707
dw 9723
dw 9747
dw 9788
dw 9828 
dw 9869
dw 9909 ;243
dw 9950
dw 9972 ;245
dw 9991
dw 10031
dw 10072
dw 10113 
dw 10153 ; 250


;------------------------------------------------
; + Public function
;------------------------------------------------
; Input: 16bit voltage held as [R0 , R1]
; Output: 8bit tempurature held in R0 (can range from 0 to 250)
; Note: No math16 calls
;------------------------------------------------
findTemperature_lookup:
	mov R5, #0 ;Start with 0 temp
	mov dptr, #TemptoVoltage
	
next_lookup:
	clr a
	movc a, @a+dptr
	mov R6, a
	clr a
	inc dptr
	movc a, @a+dptr
	mov R7, a ;Registers R6 (upper) and R7 (lower) have the temperature
	
	clr c
	mov a, R7
	subb a, R1
	mov a, R6
	subb a, R0
	
	jnc done_lookup
	
	inc R5 
	inc dptr
	
	cjne R5, #250, next_lookup ; will max temp reading of 250
	
done_lookup:
	mov a , R5	
	mov R0 , a ;R0 has the tempurature
	ret 


;------------------------------------------------
; + Public function
;------------------------------------------------
; Input: Tempurature in R0
; Output: 16 bit Voltage in [ R0 , R1 ]
; Note: V2 unknown error in n, working perhaps because of no math16 functions
;------------------------------------------------
findVoltage_lookup:	
	clr c
	mov dptr, #TemptoVoltage
	mov a, r0 
	mov b, #2 
	mul ab 
	add a, dpl 
	mov dpl, a 

	mov a, b
	addc a , dph
	mov dph , a 
	
	clr a
	movc a , @a+dptr 
	mov R0 , a 
	inc dptr 
	clr a 
	movc a , @a+dptr 
	mov R1 , a 
	
	ret
	   
$LIST
