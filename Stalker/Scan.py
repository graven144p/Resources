import pyfiglet
import sys
import socket
from datetime import datetime
import colorama 
from colorama import Fore

print(Fore.CYAN+" XD ")   
ascii_banner = pyfiglet.figlet_format("EVIL-ScannZZZ")
print(ascii_banner)
   
# Defining a target
if len(sys.argv) == 2:
      
    # translate hostname to IPv4
    target = socket.gethostbyname(sys.argv[1]) 
else:
    print("Invalid ammount of Argument")
  
# Add Banner 
print(Fore.BLUE+"-" * 50)
print(Fore.RED+"Scanning Target: " + target)
print(Fore.RED+"Scanning started at:" + str(datetime.now()))
print(Fore.BLUE+"-" * 50)
   
try:
    # will scan ports between 1 to 65,535
    for port in range(1,65535):
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        socket.setdefaulttimeout(1)
          
        # returns an error indicator
        result = s.connect_ex((target,port))
        if result ==0:
            print("[+] Port {} is open".format(port))
        s.close()
          
except KeyboardInterrupt:
        print("\n Exitting Program !!!!")
        sys.exit()
except socket.gaierror:
        print("\n Hostname Could Not Be Resolved !!!!")
        sys.exit()
except socket.error:
        print("\ Server not responding !!!!")
        sys.exit()