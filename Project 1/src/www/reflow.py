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
    
    
def readTemperature():
    def data_gen():
        t = data_gen.t
        while True:
           t+=1
           strin = ser.readline()
           try: 
               val = int(map(ord, strin)[0])
           except ValueError:
               val = 0
           print(val)
           yield t, val
    
    def run(data):
        # update the data
        t,y = data
        if t>-1:
            xdata.append(t)
            ydata.append(y)
            if t>xsize: # Scroll to the left.
                ax.set_xlim(t-xsize, t)
            line.set_data(xdata, ydata)
    
        return line,
    
    def on_close_figure(event):
        sys.exit(0)
    

    ser = serial.Serial( 
     port=MYPORT, 
     baudrate=115200, 
     parity=serial.PARITY_NONE, 
     stopbits=serial.STOPBITS_TWO, 
     bytesize=serial.EIGHTBITS 
    )
    
    ser.isOpen() 
    
    xsize=200
    
    data_gen.t = -1
    fig = plt.figure()
    fig.canvas.mpl_connect('close_event', on_close_figure)
    ax = fig.add_subplot(111)
    line, = ax.plot([], [], lw=2)
    ax.set_ylim(-20, 250)
    ax.set_xlim(0, xsize)
    ax.grid()
    xdata, ydata = [], []
    
    # Important: Although blit=True makes graphing faster, we need blit=False to prevent
    # spurious lines to appear when resizing the stripchart.
    ani = animation.FuncAnimation(fig, run, data_gen, blit=False, interval=100, repeat=False)
    plt.show()    
    return

#MAIN
MYPORT = 'COM3'
sendSetupVariables()
#readTemperature()
