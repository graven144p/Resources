import os 
import time 
import sys
import pyfiglet 
import colorama 
from colorama import Fore 

print(Fore.RED+" l ")
os.system(' clear ')
print(" [+] Starting password generator [+] ")
os.system(' clear ')
os.system(' clear ')
print("="*60)
banner = pyfiglet.figlet_format("PGEN", font = "isometric1" )
print(banner)
print("="*60)
print("_________________________________________________________________")
print("|[1] Generate 5 character pass | [2] Generate 10 character pass |")
time.sleep(0.1)
print("|[3] generate 15 character pass| [4] Generate 16 character pass |")
time.sleep(0.1)
print("|[5] Generate 20 character pass| [6] Generate 25 character pass | ")
time.sleep(0.1)
print("|_______________________________________________________________|")
A = input(" Options @> ")

if '1' in A:
    os.system(' clear ')
    print(" [!] GENERATING PASSWORDS [!] ")
    time.sleep(0.1)
    print(" [=] WILL SAVE TO FILE [=] ")
    time.sleep(1)
    print(" [!] Hang up with ^C [!] ")
    os.system(' python3 5.py ')

elif '2' == A:
    os.system(' clear ')
    print(" [!] GENERATING PASSWORDS [!] ")
    time.sleep(0.1)
    print(" [=] WILL SAVE TO FILE [=] ")
    time.sleep(1)
    print(" [!] Hang up with ^C [!] ")
    time.sleep(4)
    os.system(' python3 10.py ')

elif '3' == A:
    os.system(' clear ')
    print(" [!] GENERATING PASSWORDS [!] ")
    time.sleep(0.1)
    print(" [=] WILL SAVE TO FILE [=] ")
    time.sleep(1)
    print(" [!] Hang up with ^C [!] ")
    time.sleep(4)
    os.system(' python3 15.py ')


elif '4' == A:
    os.system(' clear ')
    print(" [!] GENERATING PASSWORDS [!] ")
    time.sleep(0.1)
    print(" [=] WILL SAVE TO FILE [=] ")
    time.sleep(1)
    print(" [!] Hang up with ^C [!] ")
    time.sleep(4)
    os.system(' python3 16.py ')


elif '5' == A:
    os.system(' clear ')
    print(" [!] GENERATING PASSWORDS [!] ")
    time.sleep(0.1)
    print(" [=] WILL SAVE TO FILE [=] ")
    time.sleep(1)
    print(" [!] Hang up with ^C [!] ")
    time.sleep(4)
    os.system(' python3 20.py ')    


elif '6' == A:
    os.system(' clear ')
    print(" [!] GENERATING PASSWORDS [!] ")
    time.sleep(0.1)
    print(" [=] WILL SAVE TO FILE [=] ")
    time.sleep(1)
    print(" [!] Hang up with ^C [!] ")
    time.sleep(4)
    os.system(' python3 25.py ')



