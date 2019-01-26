#!/bin/bash

#: Apply some default settings for Ubuntu.  Configures OpenSSH and lightdm, and installs fail2ban.
#: Not 100% automatic, there may be prompts/dialogs.
#: 
#: Tested on Ubuntu Desktop 18.04.1
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Some global vars
res="../../shared" # resources folder

## Install some software
sudo apt update && \
sudo apt -y install curl fail2ban openssh-client openssh-server samba hfsprogs exfat-utils exfat-fuse screen

## Hide guest account from login screen
if [[ "$( lsb_release -r -s | tr -d '.' )" -lt 1710 ]]; then
	printf "Configuring lightdm\n"
	sudo bash ./hideGuest.sh
fi

## Apply custom settings for samba
printf "Apply settings for samba\n"
sudo sed -i 's/^\[global\]/\[global\]\nusershare owner only = false/' /etc/samba/smb.conf

## Apply custom settings for ssh
printf "Apply settings for ssh\n"
sudo mv "/etc/ssh/sshd_config" "/etc/ssh/sshd_config_BACKUP.txt" # create backup
sudo cp "${res}/sshd_config" "/etc/ssh/"

## create user ssh directories
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys

mkdir -p ~/bin

## Restart affected services
printf "Restarting affected services\n"
sudo service sshd restart
sudo service smbd restart

printf "Done!\n"