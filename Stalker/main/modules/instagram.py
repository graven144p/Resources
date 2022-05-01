import os
import sys 
import requests 
import time 
import time as t
import datetime
import datetime as datetime
import json 
import requests 
import colorama 
from colorama import Fore

os.system(' clear ')

user = str(input(" Enter username ==> "))

url = f"https://www.instagram.com/{user}/" 

try:
    session = HTMLSession()
    response = session.get(url)
except requests.exceptions.RequestException as e:
    print(e)
r = session.get(url)
r.html.render(sleep=1, scrolldown=10)
articles = r.html.find('og:description') 
newslist = []
for item in articles:
    try:
        newsitem = item.find('meta property', first=True)
        newslist.append(f"{newsitem.text}\n{newsitem.absolute_links}\n")
    except:
        pass        
print(len(newslist))          
for x in newslist:
    print(x)                   



'''
# stalker 
user = str(input(" Enter username ==> "))
r = (f'view-source:https://www.instagram.com/{user}/')

#jsonn = json.loads(r.text)
#for value in jsonn:
print(Fore.BLUE+" [INFO] ===> ") #+ str(datetime.now()))
print(" [RESPONSE] ")
print(r)
t.sleep(1)
print("###############Gathering info#############")
print(description)


#jsonFile = open("insta-data.json", "w")
#jsonFile.write(f"{r.content}\n")
#jsonFile.close()
#print("*"*60)
#print('\033[31m' + 'Data saved and written to a json file')
##os.system('pwd')
#print("*"*60)
#
#reastart = str(input(" Press Enter to restart "))
'''