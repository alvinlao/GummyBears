#!/usr/bin/env python
import subprocess
import cgi
import sys
import cgitb; cgitb.enable()

import serial 


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

def showLogger():
    print """
    <html>
	<head>
		<link rel="stylesheet" href="css/run.css"/>
		<!--<script src="js/jquery2-1.js"></script>-->
      """
    echoArgs()
    print """
      
    		<script language="javascript" type="text/javascript" src="js/jquery.js"></script>
    		<script language="javascript" type="text/javascript" src="js/jquery.flot.js"></script>
    		<script src="js/run.js"></script>
    		<title>Reflow Oven Controller</title>
    	</head>
    	<body>
    		<div id="container">
    			<h1>Reflow Oven Controller</h1>
    			<div id="chart" style="width:800px; height:300px;"></div>
    			<div id="buttonContainer"><button class="start">Start</button></div>
    		</div>
    		
    		
    	</body>
    </html>

    """
    return
    
def echoArgs():
    print "<script>"
    print "     var soakRate = " + str(args[0])+";";
    print "     var soakTemp = " + str(args[1])+";";
    print "     var soakTime = " + str(args[2])+";";
    print "     var reflowRate = " + str(args[3])+";";
    print "     var reflowTemp = " + str(args[4])+";";
    print "     var reflowTime = " + str(args[5])+";";
    print "     var coolingRate = " + str(args[6])+";";
    print "</script>"
    return


#MAIN
MYPORT = 'COM3'
args = getSetupVars();
sendSetupVariables();
showLogger();