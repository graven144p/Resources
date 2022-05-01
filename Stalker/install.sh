
echo 'checking for if json is installed'
sleep 2 
pkg=json
status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
  sudo apt install $pkg
fi
sleep 0.5

if python -c "import os" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
fi

sleep 0.5

if python -c "import sys" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
fi

sleep 0.5

if python -c "import time" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
fi

sleep 0.5

if python -c "import csv" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
    echo 'installing'
    pip install csv
fi

sleep 0.5

if python -c "import colorama" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
    echo 'installing'
    pip install colorama
fi

sleep 0.5

if python -c "import phonenumbers" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
    echo 'installing'
    pip install phonenumbers
fi

sleep 0.5

if python -c "import requests" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
    echo 'installing'
    pip install requests
fi

sleep 0.5

if python -c "import urllib" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
    echo 'installing'
    pip install urllib && pip install urllib3
fi

sleep 0.5

if python -c "import twint" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
    echo 'installing'
    pip install twint
fi

sleep 0.5

if python -c "import socket" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
    echo 'installing'
    pip install socket
fi

sleep 0.5

if python -c "import webbrowser" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
    echo 'installing'
    pip install webbrowser
fi

sleep 0.5

if python -c "import pyfiglet" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
    echo 'uh oh'
    echo 'installing'
    pip install pyfiglet
fi

sleep 0.5

if python -c "import termcolor" &> /dev/null; then
    echo ' [+] all good module is installed [+] '
else
   echo ' uh oh '
   echo 'installing'
   pip install termcolor
fi
clear
sleep 2
echo '[!] running main script [!] '
python3 main.py 