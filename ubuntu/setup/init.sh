#!/bin/bash

#: Apply some settings for an Ubuntu server.   Configures OpenSSH and lightdm, and installs fail2ban. This isn't 
#: gaunrateed to be 100% automatic; you may be prompted for input or with confirm dialogs.  Must be run as root.
#: 
#: PRECONDITIONS: 
#:		1) OpenSSH is installed
#:		2) Ubuntu Desktop is installed
#: 
#: Tested on Ubuntu Server 15.10.  
#: Author: Fastily

cd `dirname "$0"`
source ../../shared/autobotUtils.sh
confirmRunAsRoot

## Some global vars
res="res" # resources folder
me="`whoami`" # current user

# set $me to the correct user if sudo was used
if [ -n "$SUDO_USER" ]; then
	me="$SUDO_USER"
fi

## Set directory for script
cd `dirname "$0"`

## Install some software
printf "Installing fail2ban\n"
apt-get update
apt-get -y install fail2ban

## Hide guest account from login screen
printf "Configuring lightdm\n"
mkdir -p /etc/lightdm
cp "$res"/lightdm.conf /etc/lightdm/

## Apply custom settings for fail2ban
printf "Apply settings for fail2ban\n"
cp "$res"/jail.local /etc/fail2ban/

## Apply custom settings for ssh
printf "Apply settings for ssh\n"
mv /etc/ssh/sshd_config ~/sshd_config_backup.txt # create backup in user's home dir
chown "$me" ~/sshd_config_backup.txt

cp "$res"/sshd_config /etc/ssh/

if [ ! -d ~/.ssh ]; then
	mkdir -p ~/.ssh
	chown "$me" ~/.ssh
	
	touch ~/.ssh/authorized_keys
	chown "$me" ~/.ssh/authorized_keys
fi

## Restart affected services
printf "Restarting affected services\n"
service sshd restart
service fail2ban restart

printf "All Done!\n"