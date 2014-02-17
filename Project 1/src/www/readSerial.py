import serial
import time

ser = serial.Serial( 
 port='COM5', 
 baudrate=115200, 
 parity=serial.PARITY_NONE, 
 stopbits=serial.STOPBITS_TWO, 
 bytesize=serial.EIGHTBITS 
)

ser.isOpen() 


while(True):
    strin = ser.readline()
    try: 
       val = int(map(ord, strin)[0])
    except ValueError:
       val = 0
       
    f = open('temp.json', 'w')    
    f.write('{"data": '+str(val)+'}')
    f.close()
    time.sleep(1)
    
ser.close()