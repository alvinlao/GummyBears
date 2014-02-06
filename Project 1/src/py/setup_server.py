import sys, time, math
import serial 
 
# configure the serial port 
ser = serial.Serial( 
 port='COM9', 
 baudrate=115200, 
 parity=serial.PARITY_NONE, 
 stopbits=serial.STOPBITS_TWO, 
 bytesize=serial.EIGHTBITS 
)

ser.isOpen()
ser.write(chr(0x1))
ser.close()