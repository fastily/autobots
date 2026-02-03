#!/bin/bash

#: Install some helpful packages and apply sane settings for Raspberry Pi OS
#: 
#: Tested on Raspberry Pi OS Buster
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e

## Install packages
sudo apt update
sudo apt -y install fail2ban jq

## Apply custom settings for ssh
sudo tee "/etc/ssh/sshd_config.d/10-my-ssh.conf" > /dev/null << EOF
PermitRootLogin no
PasswordAuthentication no
EOF

mkdir -p ~/.ssh
echo 'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDVS+ueZU1A4iHGyEKlQ0RzjcU9cio708BpFMZJeGGaP chungus_pi' >> ~/.ssh/authorized_keys

sudo touch "/boot/firmware/ssh" # enable ssh

## Setup bin and aliases
mkdir -p ~/.config/containers
bash ../scripts/deploy.sh

cat << EOF >> ~/".bash_aliases"

alias dcla="docker container ls -a "
alias dlf="docker container logs -f -n 1000 "
alias uuaa="sudo apt update && sudo apt upgrade -y && sudo apt autoclean && sudo apt autoremove -y"
alias uuaar="uuaa && sleep 5 && sudo reboot"
alias uuaas="uuaa && sleep 5 && sudo shutdown now"
EOF

sudo timedatectl set-timezone Etc/UTC

echo "Done!"