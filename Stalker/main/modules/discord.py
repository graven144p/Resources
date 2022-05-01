import requests 
import os
import time as t 
import sys 
import json 
from datetime import datetime
import colorama 
from colorama import Fore 
from colorama import init 


print("==========================")
user = str(input("channel ID @> "))
print("===========================")
auth = str(input("Auth key @> "))

def restart_program():
   python = sys.executable
   os.execl(python, python, * sys.argv)
   curdir = os.getcwd()


def retrieve_messages(channelid):
    headers = {
        'authorization': f'{auth}'
    }
    
    r = requests.get(f'https://discord.com/api/v9/channels/{channelid}/messages', headers=headers)
    jsonn = json.loads(r.text)
    for value in jsonn:
        print(Fore.RED+"")
        print("[CREDITS AKA ME] ===> ArkAngeL43 ")
        print(Fore.RED+"[INFO] ===> " + str(datetime.now()))
        print(Fore.BLUE+"")
        print(value, '\n')
        jsonFile = open("data.json", "w")
        jsonFile.write(f"{r.text}\n")
        jsonFile.close()
        # if want just the content 

retrieve_messages(f'{user}')


