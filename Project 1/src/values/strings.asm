;------------------------------------------------
; strings.asm
;------------------------------------------------
; Strings
; Display strings on LCD
;------------------------------------------------

$NOLIST
CSEG
;------------------------------------------------
; LCD.asm
;------------------------------------------------
WELCOME_STRINGS:			DB '    WELCOME!    ', 'REFLOW SOLDERING'
WAIT_EXT_STRINGS:			DB ' WAITING SETUP  ', ' VARS FROM COMP '
FINISH_EXT_STRINGS:			DB ' GOT VARS FROM  ', '    COMPUTER    '


DEFAULT1_STRINGS:			DB '      SET       ', '   DEFAULT 1    '
DEFAULT2_STRINGS:			DB '      SET       ', '   DEFAULT 2    '
DEFAULT3_STRINGS:			DB '      SET       ', '   DEFAULT 3    '

SETREFLOWRATE_STRINGS:		DB 'Set Reflow Rate ', '                '
SETREFLOWTIME_STRINGS:		DB 'Set Reflow Time ', '                '
SETREFLOWTEMP_STRINGS:		DB '   Set Reflow   ', '  Temperature   '
SETSOAKRATE_STRINGS:		DB ' Set Soak Rate  ', '                '
SETCOOLRATE_STRINGS:		DB ' Set Cool Rate  ', '                '
SETSOAKTIME_STRINGS:		DB ' Set Soak Time  ', '                '
SETSOAKTEMPERATURE_STRINGS:	DB '    Set Soak    ', '  Temperature   '

PREHEATSOAK_STRINGS:		DB 'Heating to Soak ', '                '
SOAK_STRINGS:				DB '      Soak      ', '                '
PREHEATREFLOW_STRINGS:		DB ' Heat to Reflow ', '                '
REFLOW_STRINGS:				DB '     Reflow     ', '                '
COOLDOWN_STRINGS: 			DB '  Cooling down  ', '                '

STOPPED_STRINGS:            DB '    STOPPED!    ', '                '
FINISHED_STRINGS: 			DB 'Cooling Complete', '   PCD Ready!   '
OVERHEAT_STRINGS: 			DB 'Temp Over 25 Deg', '  Overheat Stop '

Nothing_Strings:			DB '                ', '                '

;219 is all pixels on
PROGRESS_0_STRINGS:				DB '    PROGRESS    ', '                '
PROGRESS_25_STRINGS:			DB '    PROGRESS    ', 219, 219, 219, 219, '            '
PROGRESS_50_STRINGS:			DB '    PROGRESS    ', 219, 219, 219, 219, 219, 219, 219, 219,'        '
PROGRESS_75_STRINGS:			DB '    PROGRESS    ', 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, '    '
PROGRESS_100_STRINGS:			DB '    PROGRESS    ', 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219, 219

$LIST
