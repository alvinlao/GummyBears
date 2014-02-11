#!/usr/bin/env python

import cgi
import sys
import cgitb; cgitb.enable()

import time, math
import serial 

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation


def getSetupVars():
    form = cgi.FieldStorage()
    soakRate = form.getvalue('soakRate', 0)
    soakTemp = form.getvalue('soakTemp', 0)
    soakTime = form.getvalue('soakTime', 0)
    reflowRate = form.getvalue('reflowRate', 0)
    reflowTemp = form.getvalue('reflowTemp', 0)
    reflowTime = form.getvalue('reflowTime', 0)
    coolingRate = form.getvalue('coolingRate', 0)
    
    return [int(soakRate), int(soakTemp), int(soakTime), int(reflowRate), int(reflowTemp), int(reflowTime), int(coolingRate)]

    
def sendSetupVariables():
    args = getSetupVars()
    #args=[3, 100, 100, 3, 200, 20, 50]
    print "Content-type: text/html"
    print
    print "<html><head><title>Reflow Oven</title></head>"
    print "<body>"
    print "<p>Setup variables sent!</p>"
    print args
    print "</body></html>"
    
    ser = serial.Serial(
     port=MYPORT, 
     baudrate=115200, 
     parity=serial.PARITY_NONE, 
     stopbits=serial.STOPBITS_TWO, 
     bytesize=serial.EIGHTBITS 
    )

    ser.isOpen()
    for arg in args:
        ser.write(chr(arg))
    ser.close()
    
    return

#MAIN
MYPORT = 'COM6'
sendSetupVariables()
