import pyfiglet
import os 
import sys 
import time as t
import colorama 
from colorama import Fore 
from colorama import init
from datetime import datetime
import twint 
import phonenumbers
from phonenumbers import timezone 
from phonenumbers import carrier
from phonenumbers import geocoder, carrier
import requests
import urllib
from urllib.request import urlopen as open
import webbrowser 
from termcolor import colored
from requests import get 
import socket
from datetime import datetime

os.system(' clear ')

init()



def restart_program():
    python = sys.executable
    os.execl(python, python, * sys.argv)

print(Fore.RED+"")
banner = pyfiglet.figlet_format("Stalker", font = "slant" )
print(banner)
print("                                          V1.0")
t.sleep(1)

A = str(input(" @> "))


if 'help' in A:
          print(Fore.BLUE+"|==========================================|")
          print(Fore.BLUE+"|[1] Github Osint         [2] Discord Osint|")
          print(Fore.BLUE+"|[3] Twitter Osint        [4] Phone Osint  |")
          print(Fore.BLUE+"|[5] IP                   [6] IP Scanner   |")
          print(Fore.BLUE+"|==========================================|")          
          t.sleep(1)
          A = str(input(" Press Enter to go back"))
          os.system(' clear ')
          restart_program()


elif '1' in A:
         os.system(' clear ')
         print(banner)
         user = str(input(" Enter username ==> "))
         #request being sent for information
         r = requests.get(f'https://api.github.com/users/{user}')
         #time 
         print(Fore.BLUE+" [INFO] ===> " + str(datetime.now()))
         print("[RESPONSE] ===>")
         print(r)
         #with open("user.txt","r+",encoding="utf-8") as F:
         #    F.write("[RESPONSE]")
         #    F.write(str(r))
         #    for x in F:
         #        print(x)
         t.sleep(1)
         print("################################Gathering info###########################")
         print(r.content)
         print("#"*60)
         print('\033[31m' + 'Make sure to save this!')
         print("*"*60)
         restart = str(input(" Press Enter to restart "))
         #sys.stdout.close()
         restart_program()
                #print(r.content ['login'], '\n')
                #print(r.content

elif '2' in A:
         t.sleep(1)
         os.system(' clear ')
         print(banner)
         print("                                          V1.0")
         os.system(' cd main && cd modules && python3 discord.py ')         
         restart = str(input(" Press Enter to restart "))
         restart_program()

elif '3' in A:
    A = str(input("User @> "))
    t.sleep(1)
    os.system(' clear ')
    print("______________________________")
    print("|Would you like the user ID's|")
    print("|To be saved to a output file|")
    print("|____________________________|")
    print(" True or False? ")
    B = str(input(" @> "))
    os.system(' clear ')
    print("|-----------------------|")
    print("|name of file for output|")
    print("|-----------------------|")
    t.sleep(1)
    file = str(input(" @> "))
    os.system(' clear ')
    t.sleep(1)
    print(Fore.CYAN+" XD ")
    os.system(' clear ')
    print(" ______________________________________________")
    print(" | How much tweets would you like to limit to | ")
    print(" | limit = 1-3200 Tweets Per Search           | ")
    print(" |--------------------------------------------|")
    num = str(input(" @> "))
    t.sleep(1)
    os.system(' clear ')
    print(Fore.RED+"")
    print(banner)
    print("                                          V1.0")
    print(" Stalker will start Scraping in a few moments....")
    t.sleep(5)
    c = twint.Config()
    c.Username = f"{A}" #formating for string 
    c.Custom["tweet"] = ["id"]
    c.Custom["user"] = ["bio"] 
    c.Limit = f"{num}"
    c.Store_csv = f"{B}" 
    c.Output = f"{file}"
    twint.run.Search(c)
    print(banner)
    print("[=] stalker has stopped scrapping [=] ")
    A = str(input(" Press Enter to restart"))
    restart_program()

elif '4' == A:
    os.system(' clear ')
    print(Fore.RED+"XDDDDD")
    os.system(' clear ')
    print(banner)
    t.sleep(1)
    print(Fore.LIGHTBLACK_EX+" usage EX| +1 000-000-000")
    ph = str(input(" @> "))
    phoneNumber = phonenumbers.parse(f"{ph}")
    timeZone = timezone.time_zones_for_number(phoneNumber)
    Carrier = carrier.name_for_number(phoneNumber, 'en')
    Region = geocoder.description_for_number(phoneNumber, 'en')
    valid = phonenumbers.is_valid_number(phoneNumber)
    possible = phonenumbers.is_possible_number(phoneNumber)
    print("=======NUMBER======")
    t.sleep(0.1)
    print(phoneNumber)
    t.sleep(0.1)
    print("========TIMEZ=======")
    t.sleep(0.1)
    print(timeZone)
    t.sleep(0.1)
    print("========ISP=========")
    t.sleep(0.1)
    print(Carrier)
    t.sleep(0.1)
    print("=======REGION=======")
    t.sleep(0.1)
    print(Region)
    t.sleep(0.1)
    print("======VALID=========")
    t.sleep(0.1)
    print(valid)
    t.sleep(0.1)
    print("======Possible======")
    t.sleep(0.1)
    print(possible)
    t.sleep(0.1)
    print("=================")
   # jsonFile = open("Phone.json", "w")
   # jsonFile.write(f"{phoneNumber}{timeZone}{Carrier}{Region}{valid}{possible}\n")
   # jsonFile.close()
    print(" this has been saved to the current file location")
    enter = str(input(" Press enter to go back "))
    restart_program()

elif '5' == A:
    t.sleep(1)
    os.system(' clear ')
    print(banner)
    global ip
    ip = input("\033[1;36mEnter Your Target IP: \033[1;36m")

    if 'Exit' in ip:
            os.system(' clear ')
            t.sleep(1)
            print(" [+] Thanks for stopping by [+] ")
            print(" [=] Have a good one :D     [=]")
            t.sleep(2)
            sys.exit()

    elif 'exit' in ip:
                os.system(' clear ')
                t.sleep(1)
                print(" [+] Thanks for stopping by [+] ")
                print(" [=] Have a good one :D     [=]")
                t.sleep(2)
                sys.exit()

    import json
    url = "http://ip-api.com/json/"
    response = open(url + ip)
    data = response.read()
    values = json.loads(data)
    status = values['status']
    success = "success"
    lat = str(values['lat'])
    lon = str(values['lon'])
    a = lat + ","
    b = lon + "/"
    c = b + "data=!3m1!1e3?hl=en"
    location = a + c
    os.system(' mpg123 loc.mp3 ')
    os.system(' clear ')
    print(banner)
    print("---------------------------------")
    t.sleep(0.1)
    print(" [=] IP: " + values['query']        )
    t.sleep(0.1)
    print(" [=] Status: " + values['status']   )
    t.sleep(0.1)
    print(" [=] city: " + values['city']       )
    t.sleep(0.1)
    print(" [=] ISP: " + values['isp']         )
    t.sleep(0.1)
    print(" [=] latitude: " + lat              )
    t.sleep(0.1)
    print(" [=] longitude: " + lon             )
    t.sleep(0.1)
    print(" [=] country: " + values['country'] )
    t.sleep(0.1)
    print(" [=] region: " + values['regionName'])
    t.sleep(0.1)
    print(" [=] city: " + values['city']       )
    t.sleep(0.1)
    print(" [=] zip: " + values['zip']         )
    t.sleep(0.1)
    print(" [=] AS: " + values['as']           )
    t.sleep(0.1)
    print("---------------------------------")
    t.sleep(1)
    print(" [+] opening location LINK [+] ")
    maps = "https://www.google.com/maps/search/"
    webbrowser.open(maps + location)
    print(" [-] would you like to scan the ports of this IP? ")
    t.sleep(2)
    B = str(input(" ┌─[User7]-[~/main/IPTracer]──╼"))
    t.sleep(1)
    

    if 'yes' in B:
            t.sleep(1)
            print(" [+] cleaning up [+] ")
            t.sleep(1)
            os.system(' clear ')
            os.system(f' python3 Scan.py {ip} ')

    elif 'no' in B:
            os.system(' clear ')
            print(" [-] cleaning up [-] ")
            t.sleep(1)
            sys.exit()

    elif 'No' in B:
            os.system(' clear ')
            pritn(" [-] cleaning up [-] ")
            t.sleep(1)
            sys.exit()

    elif 'Yes' in B:
            t.sleep(1)
            print(" [+] cleaning up [+] ")
            t.sleep(1)
            os.system(' clear ')
            os.system(f' python3 Scan.py {ip} ')            


    elif 'sure' in B:
                t.sleep(1)
                print(" [+] cleaning up [+] ")
                t.sleep(1)
                os.system(' clear ')
                os.system(f' python3 Scan.py {ip} ')      

    elif 'YE' in B:
            t.sleep(1)
            print(" [+] cleaning up [+] ")
            t.sleep(1)
            os.system(' clear ')
            os.system(f' python3 Scan.py {ip} ')      

    elif 'YEE' in B:
            t.sleep(1)
            print(" [+] cleaning up [+] ")
            t.sleep(1)
            os.system(' clear ')
            os.system(f' python3 Scan.py {ip} ')   

elif '6' == A:
    t.sleep(1)
    os.system(' clear ')
    print(banner)
    print(" Waitng for cunt kiddies to fuck off")
    print(" Loading ....")
    t.sleep(15)
    ip = str(input(" Whats the IPA $>>> "))
    os.system(' clear ')
    os.system(f' python3 Scan.py {ip} ')
    B = str(input(" Press Enter to restart => "))
    restart_program()