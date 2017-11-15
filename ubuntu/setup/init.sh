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
apt install curl fail2ban openssh-client openssh-server samba

## Hide guest account from login screen
printf "Configuring lightdm\n"
bash ./hideGuest.sh

## Apply custom settings for fail2ban
printf "Apply settings for fail2ban\n"
cp "$res"/jail.local /etc/fail2ban/

## Apply custom settings for samba
printf "Apply settings for samba\n"
sed -i 's/^\[global\]/\[global\]\nusershare owner only = false/' /etc/samba/smb.conf

## Apply custom settings for ssh
printf "Apply settings for ssh\n"
mv /etc/ssh/sshd_config ~/sshd_config_backup.txt # create backup in user's home dir
chown "$me" ~/sshd_config_backup.txt

cp "$res"/sshd_config /etc/ssh/

if [ ! -d ~/.ssh ]; then
	mkdirWithOwner ~/.ssh "$me"
	touchWithOwner ~/.ssh/authorized_keys "$me"
fi

## Restart affected services
printf "Restarting affected services\n"
service sshd restart
service fail2ban restart
service smbd restart

## Install extra filesystems
printf "Installing ExFat and HFS+ support\n"
apt install hfsprogs exfat-utils exfat-fuse

printf "All Done!\n"