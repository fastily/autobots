#!/bin/bash

#: Apply custom settings for Raspbian.   This isn't 
#: gaunrateed to be 100% automatic; you may be prompted for input or with confirm dialogs.  
#: Must be run as root.
#: 
#: PRECONDITIONS: 
#:		1) OpenSSH is installed
#: 
#: Tested on Raspbian March 2016
#: Author: Fastily

cd "${0%/*}" &> /dev/null
source ../shared/autobotUtils.sh
confirmRunAsRoot

## Some globals
res="../shared"
me="pi"
home="/home/${me}"

## Configure ssh
printf "Apply settings for ssh\n"
mv /etc/ssh/sshd_config /etc/ssh/sshd_config_backup.txt # create backup in user's home dir
cp "$res"/sshd_config /etc/ssh/

if [ ! -d "$home"/.ssh ]; then
	mkdirWithOwner "$home"/.ssh "$me"
	touchWithOwner "$home"/.ssh/authorized_keys "$me"
fi

mkdirWithOwner "$home"/bin "$me"
printf '\nPATH=$PATH:$HOME/bin' >> "$home"/.bashrc

## Install fail2ban
printf "Installing fail2ban\n"
apt update
apt install fail2ban
printf "Apply settings for fail2ban\n"
cp "$res"/jail.local /etc/fail2ban/

## Enable ssh
systemctl enable ssh
systemctl start ssh

## Restart affected services
printf "Restarting affected services\n"
service fail2ban restart

printf "Done!\n"