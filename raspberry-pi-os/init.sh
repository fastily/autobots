#!/bin/bash

#: Install some helpful packages and apply sane settings for Raspberry Pi OS
#: 
#: Tested on Raspberry Pi OS Buster
#: Author: Fastily

cd "${0%/*}" &> /dev/null

set -e

## Install packages
sudo apt update && sudo apt -y install fail2ban

## Apply custom settings for ssh
sshdConfig="/etc/ssh/sshd_config"
cp "$sshdConfig" /tmp
sudo sed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$sshdConfig"
sudo sed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$sshdConfig"

mkdir -p ~/.ssh
printf 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDVS+ueZU1A4iHGyEKlQ0RzjcU9cio708BpFMZJeGGaP chungus_pi\n' >> ~/.ssh/authorized_keys

sudo systemctl enable ssh
sudo systemctl start ssh
sudo systemctl restart ssh

## Setup bin and aliases
mkdir -p ~/bin
cp -v util/* ~/bin

cat << EOF >> ~/".bash_aliases"

alias uuaa="sudo apt update && sudo apt upgrade -y && sudo apt autoclean && sudo apt autoremove -y"
alias uuaar="uuaa && sleep 5 && sudo reboot"
alias uuaas="uuaa && sleep 5 && sudo shutdown -h now"
alias showRaspbianVersion="cat /etc/os-release"
EOF

printf "Done!\n"