#!/bin/bash

#: Apply custom settings for Raspbian. This isn't 100% automatic; 
#: you may be prompted for input or with confirm dialogs.  
#: 
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Globals
res="../shared"

## Setup ssh
printf "Apply settings for ssh\n"
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config_backup.txt
sudo cp "${res}/sshd_config" /etc/ssh/

mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys

sudo systemctl enable ssh
sudo systemctl start ssh

## Setup bin directory
mkdir -p ~/bin
printf '\nPATH=$PATH:$HOME/bin' >> ~/.bashrc

## Install fail2ban
sudo apt update && \
sudo apt -y install fail2ban && \
sudo cp "${res}/jail.local" /etc/fail2ban/ && \
sudo service fail2ban restart

printf "Done!\n"