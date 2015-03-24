#!/bin/bash
# This is a bash script to play your ansible files to install
# LAMP and wordpress on a Centos 6.5 server
# Read target machine from user
# Written by J.Jolliffe
# History : My First attempt at using ansible and AWS 
# Found that ansible installs cleanly on ubuntu ( I used 14 )
# Note if on ubuntu you have to use sudo - change script accordinglyu 
echo -n "Input the ip of your target machine "
read target
echo -n "Input a password for wordpress "
read password

echo "Target machine is $target and wordpress passwd is $password"
while true; do
	echo "Is this correct do you wish to continue?(y/n)"
	read x
	case $x in
		[Yy]* ) break;;
		[Nn]* ) echo "Please run this script again";exit;;
       		  * ) echo "Please answer y or n.";;
	esac
done
# Generate an new SSH Key
sudo ssh -i testkeypair.pem root@$target "exit"
sed 's/TARGET/'"$target"'/' ansible.tp > ansible.sh
chmod 777 ansible.sh
sed -i 's/WP_PASSWORD/'"$password"'/'  ansible.sh
/home/ubuntu/ansible.sh
