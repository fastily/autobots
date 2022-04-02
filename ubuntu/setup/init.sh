#!/bin/bash

#: Install some helpful packages and apply sane settings for Ubuntu Server/Desktop.
#: 
#: Tested on Ubuntu Desktop 18.04.2
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Install packages
sudo apt update && sudo apt -y install curl exfat-fuse exfat-utils fail2ban hfsprogs iperf3 net-tools screen smartmontools

## Install Samba
bash ../installers/Samba.sh

## Install OpenSSH
bash ../installers/OpenSSH.sh

## Configure ~/bin and aliases
bash confEnv.sh

printf "Done!\n"