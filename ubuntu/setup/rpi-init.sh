#!/bin/bash

#: Install some helpful packages and apply sane settings for Ubuntu on Raspberry pi 2/3.
#: 
#: Tested on Ubuntu 18.04.2
#: Author: Fastily

# cd "${0%/*}" &> /dev/null

## Install packages
sudo apt update && \
sudo apt -y install fail2ban openjdk-11-jre-headless

## Apply custom settings for ssh
sshdConfig="/etc/ssh/sshd_config"
sudo cp "$sshdConfig" "${sshdConfig}_BACKUP.txt" # create backup
sudo sed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$sshdConfig"
sudo sed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$sshdConfig"

mkdir -p ~/.ssh
curl 'https://gist.githubusercontent.com/fastily/4695d2bca65d91958f602bfb8d497def/raw/fd1b441b9f36c620ac0a3f1d9db5cb87b5cd4d3d/pi.pub' >> ~/.ssh/authorized_keys

sudo service ssh restart

## Configure user bin and aliases
mkdir -p ~/bin
printf '\nalias uuu="sudo apt update && sudo apt upgrade -y"' >> ~/.bash_aliases
printf '\nalias aaa="sudo apt autoclean && sudo apt autoremove -y"' >> ~/.bash_aliases

printf "Done!\n"