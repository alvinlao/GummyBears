#!/usr/bin/env python

import cgi
import sys
import cgitb; cgitb.enable()
#import time, math
#import serial 

def sendSetupVariables():
    form = cgi.FieldStorage()
    soakRate = form.getvalue('soakRate')
    soakTemp = form.getvalue('soakTemp')
    soakTime = form.getvalue('soakTime')
    reflowRate = form.getvalue('reflowRate')
    reflowTemp = form.getvalue('reflowTemp')
    reflowTime = form.getvalue('reflowTime')
    coolingRate = form.getvalue('coolingRate')
    return

def readTemperature():
    return
    
'''
def sendSerial(args):
	# configure the serial port 
	ser = serial.Serial( 
	 port='COM9', 
	 baudrate=115200, 
	 parity=serial.PARITY_NONE, 
	 stopbits=serial.STOPBITS_TWO, 
	 bytesize=serial.EIGHTBITS 
	)

	ser.isOpen()
	for arg in args:
		ser.write(chr(arg))
	ser.close()
'''


#MAIN
sendSetupVariables()
readTemperature()
