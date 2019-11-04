#!/bin/bash

#: Set up OpenSSH client and server for Ubuntu.
#: 
#: Intended for Ubuntu 18.04
#: Author: Fastily

sudo apt update && sudo apt -y install openssh-client openssh-server

## Harden sshd - disallow root login and password auth
sshdConfig="/etc/ssh/sshd_config"
sudo cp "$sshdConfig" "${sshdConfig}_BACKUP.txt" # create backup
sudo sed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$sshdConfig"
sudo sed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$sshdConfig"
sudo service sshd restart

## create config files
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys