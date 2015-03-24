#!/bin/bash
# This is a bash script to play your ansible files to install
# LAMP and wordpress on a Centos 6.5 server
# Read target machine from user
# Written by J.Jolliffe
# History : My First attempt at using ansible and AWS 
# Found that ansible installs cleanly on ubuntu ( I used 14 )
# Note if on ubuntu you have to use sudo - change script accordinglyu 

#ssh-keygen -y -f testkeypair.pem -b 2048 -t rsa  -q -N "" > key.pub
# I could not find a way to ssh-copy-id this or scp this on AWS and pem
# sudo ssh -i testkeypair.pem root@$target
#run playbook to install apache
echo " Installing Apache please wait"
ansible-playbook apache.yml --extra-vars "target=172.31.5.118" --private-key testkeypair.pem -vvvv
echo " Installing Mysql please wait"
ansible-playbook mysql.yml --extra-vars "target=172.31.5.118" --private-key testkeypair.pem
echo " Installing Php and extensions please wait"
ansible-playbook php.yml --extra-vars "target=172.31.5.118" --private-key testkeypair.pem
echo " Installing wordpress database please wait"
ansible-playbook wordpress_db.yml --extra-vars "target=172.31.5.118 , wp_password=welcome" --private-key testkeypair.pem
# subsitute in wp_passwd to wp_config.php
sed 's/WP_PASSWD/welcome/' wp-config.tp >wp-config.php
echo " Installing wordpress site please wait"
ansible-playbook wordpress_site.yml --extra-vars "target=172.31.5.118" --private-key testkeypair.pem
echo " Nearly finished ..wait"
ansible-playbook extra.yml --extra-vars "target=172.31.5.118" --private-key testkeypair.pem
echo " Please test you wordpress site at https://your virtual machine ip "

