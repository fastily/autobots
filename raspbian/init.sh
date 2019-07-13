#!/bin/bash

#: Apply custom settings for Raspbian. This isn't 100% automatic; 
#: you may be prompted for input or with confirm dialogs.  
#: 
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Globals
res="../shared"

## Install packages
sudo apt update && sudo apt -y install fail2ban

## Setup ssh
printf "Apply settings for ssh\n"
sudo mv "/etc/ssh/sshd_config" "/etc/ssh/sshd_config_BACKUP.txt"
sudo cp "${res}/sshd_config" "/etc/ssh/"

mkdir -p ~/.ssh
curl 'https://gist.githubusercontent.com/fastily/4695d2bca65d91958f602bfb8d497def/raw/fd1b441b9f36c620ac0a3f1d9db5cb87b5cd4d3d/pi.pub' >> ~/.ssh/authorized_keys

# sudo systemctl enable ssh
# sudo systemctl start ssh
sudo systemctl restart ssh

## Setup bin and aliases
mkdir -p ~/bin
printf '\nalias uuu="sudo apt update && sudo apt upgrade -y"' >> ~/.bash_aliases
printf '\nalias aaa="sudo apt autoclean && sudo apt autoremove -y"' >> ~/.bash_aliases

printf "Done!\n"