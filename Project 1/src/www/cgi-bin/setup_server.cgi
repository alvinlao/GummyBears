#!/usr/bin/env python

import cgi
import sys
#import time, math
#import serial 


form = cgi.FieldStorage()
soakRate = form.getvalue('soakRate')
soakTemp = form.getvalue('soakTemp')
soakTime = form.getvalue('soakTime')
reflowRate = form.getvalue('reflowRate')
reflowTemp = form.getvalue('reflowTemp')
reflowTime = form.getvalue('reflowTime')
coolingRate = form.getvalue('coolingRate')




def printAll():
	print """
	<html>
		<body>
	"""

	print(soakRate)
	print "<br/>"
	print(soakTemp)
	print "<br/>"
	print(soakTime)
	print "<br/>"
	print(reflowRate)
	print "<br/>"
	print(reflowTemp)
	print "<br/>"
	print(reflowTime)
	print "<br/>"
	print(coolingRate)

	print """
		</body>
	</html>
	"""

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
