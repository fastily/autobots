#!/bin/bash

#: Apply some default settings for Ubuntu.  Configures OpenSSH and lightdm, and installs fail2ban.
#: Not 100% automatic, there may be prompts/dialogs.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Some global vars
res="../../shared" # resources folder

## Install some software
sudo apt update && \
sudo apt -y install curl fail2ban openssh-client openssh-server samba hfsprogs exfat-utils exfat-fuse

## Hide guest account from login screen
printf "Configuring lightdm\n"
sudo bash ./hideGuest.sh

## Apply custom settings for fail2ban
printf "Apply settings for fail2ban\n"
sudo cp "${res}/jail.local" "/etc/fail2ban/"

## Apply custom settings for samba
printf "Apply settings for samba\n"
sudo sed -i 's/^\[global\]/\[global\]\nusershare owner only = false/' /etc/samba/smb.conf

## Apply custom settings for ssh
printf "Apply settings for ssh\n"
sudo mv "/etc/ssh/sshd_config" "/tmp/sshd_config_backup.txt" # create backup in /tmp
sudo cp "${res}/sshd_config" "/etc/ssh/"

## create user ssh directories
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys

mkdir -p ~/bin

## Restart affected services
printf "Restarting affected services\n"
sudo service sshd restart
sudo service fail2ban restart
sudo service smbd restart

printf "Done!\n"