;--------------------------------------------------------
; File Created by C51
; Version 1.0.0 #1034 (Dec 12 2012) (MSVC)
; This file was generated Sat Mar 29 15:39:11 2014
;--------------------------------------------------------
$name testmotor
$optc51 --model-small
	R_DSEG    segment data
	R_CSEG    segment code
	R_BSEG    segment bit
	R_XSEG    segment xdata
	R_PSEG    segment xdata
	R_ISEG    segment idata
	R_OSEG    segment data overlay
	BIT_BANK  segment data overlay
	R_HOME    segment code
	R_GSINIT  segment code
	R_IXSEG   segment xdata
	R_CONST   segment code
	R_XINIT   segment code
	R_DINIT   segment code

;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	public _main
	public _pwm_count
	public __c51_external_startup
	public _pwmR2
	public _pwmR1
	public _pwmL2
	public _pwmL1
	public _pwmcount
;--------------------------------------------------------
; Special Function Registers
;--------------------------------------------------------
_ACC            DATA 0xe0
_B              DATA 0xf0
_PSW            DATA 0xd0
_SP             DATA 0x81
_SPX            DATA 0xef
_DPL            DATA 0x82
_DPH            DATA 0x83
_DPLB           DATA 0xd4
_DPHB           DATA 0xd5
_PAGE           DATA 0xf6
_AX             DATA 0xe1
_BX             DATA 0xf7
_DSPR           DATA 0xe2
_FIRD           DATA 0xe3
_MACL           DATA 0xe4
_MACH           DATA 0xe5
_PCON           DATA 0x87
_AUXR           DATA 0x8e
_AUXR1          DATA 0xa2
_DPCF           DATA 0xa1
_CKRL           DATA 0x97
_CKCKON0        DATA 0x8f
_CKCKON1        DATA 0xaf
_CKSEL          DATA 0x85
_CLKREG         DATA 0xae
_OSCCON         DATA 0x85
_IE             DATA 0xa8
_IEN0           DATA 0xa8
_IEN1           DATA 0xb1
_IPH0           DATA 0xb7
_IP             DATA 0xb8
_IPL0           DATA 0xb8
_IPH1           DATA 0xb3
_IPL1           DATA 0xb2
_P0             DATA 0x80
_P1             DATA 0x90
_P2             DATA 0xa0
_P3             DATA 0xb0
_P4             DATA 0xc0
_P0M0           DATA 0xe6
_P0M1           DATA 0xe7
_P1M0           DATA 0xd6
_P1M1           DATA 0xd7
_P2M0           DATA 0xce
_P2M1           DATA 0xcf
_P3M0           DATA 0xc6
_P3M1           DATA 0xc7
_P4M0           DATA 0xbe
_P4M1           DATA 0xbf
_SCON           DATA 0x98
_SBUF           DATA 0x99
_SADEN          DATA 0xb9
_SADDR          DATA 0xa9
_BDRCON         DATA 0x9b
_BRL            DATA 0x9a
_TCON           DATA 0x88
_TMOD           DATA 0x89
_TCONB          DATA 0x91
_TL0            DATA 0x8a
_TH0            DATA 0x8c
_TL1            DATA 0x8b
_TH1            DATA 0x8d
_RL0            DATA 0xf2
_RH0            DATA 0xf4
_RL1            DATA 0xf3
_RH1            DATA 0xf5
_WDTRST         DATA 0xa6
_WDTPRG         DATA 0xa7
_T2CON          DATA 0xc8
_T2MOD          DATA 0xc9
_RCAP2H         DATA 0xcb
_RCAP2L         DATA 0xca
_TH2            DATA 0xcd
_TL2            DATA 0xcc
_SPCON          DATA 0xc3
_SPSTA          DATA 0xc4
_SPDAT          DATA 0xc5
_SSCON          DATA 0x93
_SSCS           DATA 0x94
_SSDAT          DATA 0x95
_SSADR          DATA 0x96
_KBLS           DATA 0x9c
_KBE            DATA 0x9d
_KBF            DATA 0x9e
_KBMOD          DATA 0x9f
_BMSEL          DATA 0x92
_FCON           DATA 0xd2
_EECON          DATA 0xd2
_ACSRA          DATA 0xa3
_ACSRB          DATA 0xab
_AREF           DATA 0xbd
_DADC           DATA 0xa4
_DADI           DATA 0xa5
_DADL           DATA 0xac
_DADH           DATA 0xad
_CCON           DATA 0xd8
_CMOD           DATA 0xd9
_CL             DATA 0xe9
_CH             DATA 0xf9
_CCAPM0         DATA 0xda
_CCAPM1         DATA 0xdb
_CCAPM2         DATA 0xdc
_CCAPM3         DATA 0xdd
_CCAPM4         DATA 0xde
_CCAP0H         DATA 0xfa
_CCAP1H         DATA 0xfb
_CCAP2H         DATA 0xfc
_CCAP3H         DATA 0xfd
_CCAP4H         DATA 0xfe
_CCAP0L         DATA 0xea
_CCAP1L         DATA 0xeb
_CCAP2L         DATA 0xec
_CCAP3L         DATA 0xed
_CCAP4L         DATA 0xee
;--------------------------------------------------------
; special function bits
;--------------------------------------------------------
_ACC_0          BIT 0xe0
_ACC_1          BIT 0xe1
_ACC_2          BIT 0xe2
_ACC_3          BIT 0xe3
_ACC_4          BIT 0xe4
_ACC_5          BIT 0xe5
_ACC_6          BIT 0xe6
_ACC_7          BIT 0xe7
_B_0            BIT 0xf0
_B_1            BIT 0xf1
_B_2            BIT 0xf2
_B_3            BIT 0xf3
_B_4            BIT 0xf4
_B_5            BIT 0xf5
_B_6            BIT 0xf6
_B_7            BIT 0xf7
_P              BIT 0xd0
_F1             BIT 0xd1
_OV             BIT 0xd2
_RS0            BIT 0xd3
_RS1            BIT 0xd4
_F0             BIT 0xd5
_AC             BIT 0xd6
_CY             BIT 0xd7
_EX0            BIT 0xa8
_ET0            BIT 0xa9
_EX1            BIT 0xaa
_ET1            BIT 0xab
_ES             BIT 0xac
_ET2            BIT 0xad
_EC             BIT 0xae
_EA             BIT 0xaf
_PX0            BIT 0xb8
_PT0            BIT 0xb9
_PX1            BIT 0xba
_PT1            BIT 0xbb
_PS             BIT 0xbc
_PT2            BIT 0xbd
_IP0D           BIT 0xbf
_PPCL           BIT 0xbe
_PT2L           BIT 0xbd
_PLS            BIT 0xbc
_PT1L           BIT 0xbb
_PX1L           BIT 0xba
_PT0L           BIT 0xb9
_PX0L           BIT 0xb8
_P0_0           BIT 0x80
_P0_1           BIT 0x81
_P0_2           BIT 0x82
_P0_3           BIT 0x83
_P0_4           BIT 0x84
_P0_5           BIT 0x85
_P0_6           BIT 0x86
_P0_7           BIT 0x87
_P1_0           BIT 0x90
_P1_1           BIT 0x91
_P1_2           BIT 0x92
_P1_3           BIT 0x93
_P1_4           BIT 0x94
_P1_5           BIT 0x95
_P1_6           BIT 0x96
_P1_7           BIT 0x97
_P2_0           BIT 0xa0
_P2_1           BIT 0xa1
_P2_2           BIT 0xa2
_P2_3           BIT 0xa3
_P2_4           BIT 0xa4
_P2_5           BIT 0xa5
_P2_6           BIT 0xa6
_P2_7           BIT 0xa7
_P3_0           BIT 0xb0
_P3_1           BIT 0xb1
_P3_2           BIT 0xb2
_P3_3           BIT 0xb3
_P3_4           BIT 0xb4
_P3_5           BIT 0xb5
_P3_6           BIT 0xb6
_P3_7           BIT 0xb7
_RXD            BIT 0xb0
_TXD            BIT 0xb1
_INT0           BIT 0xb2
_INT1           BIT 0xb3
_T0             BIT 0xb4
_T1             BIT 0xb5
_WR             BIT 0xb6
_RD             BIT 0xb7
_P4_0           BIT 0xc0
_P4_1           BIT 0xc1
_P4_2           BIT 0xc2
_P4_3           BIT 0xc3
_P4_4           BIT 0xc4
_P4_5           BIT 0xc5
_P4_6           BIT 0xc6
_P4_7           BIT 0xc7
_RI             BIT 0x98
_TI             BIT 0x99
_RB8            BIT 0x9a
_TB8            BIT 0x9b
_REN            BIT 0x9c
_SM2            BIT 0x9d
_SM1            BIT 0x9e
_SM0            BIT 0x9f
_IT0            BIT 0x88
_IE0            BIT 0x89
_IT1            BIT 0x8a
_IE1            BIT 0x8b
_TR0            BIT 0x8c
_TF0            BIT 0x8d
_TR1            BIT 0x8e
_TF1            BIT 0x8f
_CP_RL2         BIT 0xc8
_C_T2           BIT 0xc9
_TR2            BIT 0xca
_EXEN2          BIT 0xcb
_TCLK           BIT 0xcc
_RCLK           BIT 0xcd
_EXF2           BIT 0xce
_TF2            BIT 0xcf
_CF             BIT 0xdf
_CR             BIT 0xde
_CCF4           BIT 0xdc
_CCF3           BIT 0xdb
_CCF2           BIT 0xda
_CCF1           BIT 0xd9
_CCF0           BIT 0xd8
;--------------------------------------------------------
; overlayable register banks
;--------------------------------------------------------
	rbank0 segment data overlay
;--------------------------------------------------------
; internal ram data
;--------------------------------------------------------
	rseg R_DSEG
_pwmcount:
	ds 1
_pwmL1:
	ds 1
_pwmL2:
	ds 1
_pwmR1:
	ds 1
_pwmR2:
	ds 1
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
	rseg R_OSEG
;--------------------------------------------------------
; indirectly addressable internal ram data
;--------------------------------------------------------
	rseg R_ISEG
;--------------------------------------------------------
; absolute internal ram data
;--------------------------------------------------------
	DSEG
;--------------------------------------------------------
; bit data
;--------------------------------------------------------
	rseg R_BSEG
;--------------------------------------------------------
; paged external ram data
;--------------------------------------------------------
	rseg R_PSEG
;--------------------------------------------------------
; external ram data
;--------------------------------------------------------
	rseg R_XSEG
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	XSEG
;--------------------------------------------------------
; external initialized ram data
;--------------------------------------------------------
	rseg R_IXSEG
	rseg R_HOME
	rseg R_GSINIT
	rseg R_CSEG
;--------------------------------------------------------
; Reset entry point and interrupt vectors
;--------------------------------------------------------
	CSEG at 0x0000
	ljmp	_crt0
	CSEG at 0x000b
	ljmp	_pwm_count
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	rseg R_HOME
	rseg R_GSINIT
	rseg R_GSINIT
;--------------------------------------------------------
; data variables initialization
;--------------------------------------------------------
	rseg R_DINIT
	; The linker places a 'ret' at the end of segment R_DINIT.
;--------------------------------------------------------
; code
;--------------------------------------------------------
	rseg R_CSEG
;------------------------------------------------------------
;Allocation info for local variables in function '_c51_external_startup'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:15: unsigned char _c51_external_startup(void)
;	-----------------------------------------
;	 function _c51_external_startup
;	-----------------------------------------
__c51_external_startup:
	using	0
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:18: P0M0=0;	P0M1=0;
	mov	_P0M0,#0x00
	mov	_P0M1,#0x00
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:19: P1M0=0;	P1M1=0;
	mov	_P1M0,#0x00
	mov	_P1M1,#0x00
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:20: P2M0=0;	P2M1=0;
	mov	_P2M0,#0x00
	mov	_P2M1,#0x00
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:21: P3M0=0;	P3M1=0;
	mov	_P3M0,#0x00
	mov	_P3M1,#0x00
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:22: AUXR=0B_0001_0001; // 1152 bytes of internal XDATA, P4.4 is a general purpose I/O
	mov	_AUXR,#0x11
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:23: P4M0=0;	P4M1=0;
	mov	_P4M0,#0x00
	mov	_P4M1,#0x00
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:26: PCON|=0x80;
	orl	_PCON,#0x80
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:27: SCON = 0x52;
	mov	_SCON,#0x52
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:28: BDRCON=0;
	mov	_BDRCON,#0x00
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:29: BRL=BRG_VAL;
	mov	_BRL,#0xFA
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:30: BDRCON=BRR|TBCK|RBCK|SPD;
	mov	_BDRCON,#0x1E
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:33: TR0=0; // Stop timer 0
	clr	_TR0
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:34: TMOD=0x01; // 16-bit timer
	mov	_TMOD,#0x01
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:39: TH0=RH0=TIMER0_RELOAD_VALUE/0x100;
	mov	_RH0,#0xFF
	mov	_TH0,#0xFF
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:40: TL0=RL0=TIMER0_RELOAD_VALUE%0x100;
	mov	_RL0,#0x48
	mov	_TL0,#0x48
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:41: TR0=1; // Start timer 0 (bit 4 in TCON)
	setb	_TR0
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:42: ET0=1; // Enable timer 0 interrupt
	setb	_ET0
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:43: EA=1;  // Enable global interrupts
	setb	_EA
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:45: pwmcount = 0;
	mov	_pwmcount,#0x00
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:46: return 0;
	mov	dpl,#0x00
	ret
;------------------------------------------------------------
;Allocation info for local variables in function 'pwm_count'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:51: void pwm_count (void) interrupt 1
;	-----------------------------------------
;	 function pwm_count
;	-----------------------------------------
_pwm_count:
	push	acc
	push	psw
	mov	psw,#0x00
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:53: if(++pwmcount>99) pwmcount=0;
	inc	_pwmcount
	mov	a,_pwmcount
	add	a,#0xff - 0x63
	jnc	L003002?
	mov	_pwmcount,#0x00
L003002?:
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:55: PORT_LEFT0=(pwmL1>pwmcount)?1:0;
	clr	c
	mov	a,_pwmcount
	subb	a,_pwmL1
	mov	_P1_0,c
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:56: PORT_LEFT1=(pwmL2>pwmcount)?1:0;
	clr	c
	mov	a,_pwmcount
	subb	a,_pwmL2
	mov	_P1_1,c
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:57: PORT_RIGHT0=(pwmR1>pwmcount)?1:0;
	clr	c
	mov	a,_pwmcount
	subb	a,_pwmR1
	mov	_P1_2,c
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:58: PORT_RIGHT1=(pwmR2>pwmcount)?1:0;
	clr	c
	mov	a,_pwmcount
	subb	a,_pwmR2
	mov	_P1_3,c
	pop	psw
	pop	acc
	reti
;	eliminated unneeded push/pop dpl
;	eliminated unneeded push/pop dph
;	eliminated unneeded push/pop b
;------------------------------------------------------------
;Allocation info for local variables in function 'main'
;------------------------------------------------------------
;------------------------------------------------------------
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:61: void main (void)
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:63: while(1){
L004002?:
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:64: printf("\r\nEnter PWM_L 1 value: ");
	mov	a,#__str_0
	push	acc
	mov	a,#(__str_0 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:65: scanf("%du", &pwmL1);
	mov	a,#_pwmL1
	push	acc
	mov	a,#(_pwmL1 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_scanf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:66: printf("\r\nEnter PWM_L 2 value: ");
	mov	a,#__str_2
	push	acc
	mov	a,#(__str_2 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:67: scanf("%du", &pwmL2);
	mov	a,#_pwmL2
	push	acc
	mov	a,#(_pwmL2 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_scanf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:68: printf("\r\nEnter PWM_R 1 value: ");
	mov	a,#__str_3
	push	acc
	mov	a,#(__str_3 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:69: scanf("%du", &pwmR1);
	mov	a,#_pwmR1
	push	acc
	mov	a,#(_pwmR1 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_scanf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:70: printf("\r\nEnter PWM_R 2 value: ");
	mov	a,#__str_4
	push	acc
	mov	a,#(__str_4 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:71: scanf("%du", &pwmR2);
	mov	a,#_pwmR2
	push	acc
	mov	a,#(_pwmR2 >> 8)
	push	acc
	mov	a,#0x40
	push	acc
	mov	a,#__str_1
	push	acc
	mov	a,#(__str_1 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_scanf
	mov	a,sp
	add	a,#0xfa
	mov	sp,a
;	C:\Users\Arjinder\Desktop\EECE-281\GummyBears\project2\testmotor\testmotor.c:73: printf( "\nRunning!\n" );
	mov	a,#__str_5
	push	acc
	mov	a,#(__str_5 >> 8)
	push	acc
	mov	a,#0x80
	push	acc
	lcall	_printf
	dec	sp
	dec	sp
	dec	sp
	ljmp	L004002?
	rseg R_CSEG

	rseg R_XINIT

	rseg R_CONST
__str_0:
	db 0x0D
	db 0x0A
	db 'Enter PWM_L 1 value: '
	db 0x00
__str_1:
	db '%du'
	db 0x00
__str_2:
	db 0x0D
	db 0x0A
	db 'Enter PWM_L 2 value: '
	db 0x00
__str_3:
	db 0x0D
	db 0x0A
	db 'Enter PWM_R 1 value: '
	db 0x00
__str_4:
	db 0x0D
	db 0x0A
	db 'Enter PWM_R 2 value: '
	db 0x00
__str_5:
	db 0x0A
	db 'Running!'
	db 0x0A
	db 0x00

	CSEG

end
