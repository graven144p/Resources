# discord-lazy
a very weird bot to automate messages in python for discord 

discoerd lazy isnt what it seems, yes there is a name called lazy in it, but you will need to do some of the work to fully use this script, this is because it uses your user AUTH key, and other peoples headers to access and send messages back and fourth, when you use discord to grab this info make sure you are using their web and have DEV mode ON, then when you want to send a message press F12, go to network, send a message and grab the header or link, it should look like this 

https://discord.com/api/v9/channels/000000000000000000000000/messages


|||||||||||| WHAT YOU NEED TO FILL OUT |||||||||||

there isnt many things to fille out there all you need
to do is to cloen the script, open the file, and open the py file in your editor 

fill out the 'payload' section [[[[ this is the message you want to send ]]]]

then fill out the header = position ||||||| you cvan find your auth key in the network in the same section where you found the header for the person it should be labeled AUTH Key, copy and paste the key into the ' ' marks 

then fill out the headers

r = requests.post("link", data=payload, headers=header)
