#!/bin/bash

#: Install some helpful packages and apply sane settings for Ubuntu Server/Desktop.
#: 
#: Tested on Ubuntu Desktop 18.04.2
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Install packages
sudo apt update && sudo apt -y install curl exfat-fuse exfat-utils fail2ban hfsprogs iperf3 net-tools screen smartmontools

## Install OpenSSH
bash ../installers/OpenSSH.sh

## Configure ~/bin and aliases
bash confEnv.sh

## Configure file limits
MAX_FILES_OPEN=65536
sudo tee -a "/etc/security/limits.conf" > /dev/null <<EOF

* - nofile ${MAX_FILES_OPEN}
root - nofile ${MAX_FILES_OPEN}
EOF

ulimit -n "$MAX_FILES_OPEN"

printf "Done!\n"