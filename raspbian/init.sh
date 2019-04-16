#!/bin/bash

#: Apply custom settings for Raspbian. This isn't 100% automatic; 
#: you may be prompted for input or with confirm dialogs.  
#: 
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Globals
res="../shared"

## Install packages
sudo apt update
sudo apt -y install openjdk-8-jre fail2ban

## Setup ssh
printf "Apply settings for ssh\n"
sudo mv /etc/ssh/sshd_config /etc/ssh/sshd_config_BACKUP.txt
sudo cp "${res}/sshd_config" /etc/ssh/

mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys

sudo systemctl enable ssh
sudo systemctl start ssh

## Setup bin and aliases
mkdir -p ~/bin
printf '\nalias uuu="sudo apt update && sudo apt upgrade -y"' >> ~/.bash_aliases
printf '\nalias aaa="sudo apt autoclean && sudo apt autoremove -y"' >> ~/.bash_aliases

## Configure timezone
# sudo timedatectl set-timezone UTC

printf "Done!\n"