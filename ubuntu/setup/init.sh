#!/bin/bash

#: Apply some default settings for Ubuntu.   Configures OpenSSH and lightdm, and installs fail2ban. This isn't 
#: gaunrateed to be 100% automatic; you may be prompted for input or with confirm dialogs.  Must be run as root.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

cd "${0%/*}" &> /dev/null
source ../../shared/autobotUtils.sh
confirmRunAsRoot

## Some global vars
res="../../shared" # resources folder
me="$( whoami )" # current user

# set $me to the correct user if sudo was used
if [ -n "$SUDO_USER" ]; then
	me="$SUDO_USER"
fi

## Install some software
apt update
apt install fail2ban openssh-client openssh-server

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

## Install extra filesystems
printf "Installing ExFat and HFS+ support\n"
apt install hfsprogs exfat-utils exfat-fuse

printf "All Done!\n"