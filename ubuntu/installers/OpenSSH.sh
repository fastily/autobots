#!/bin/bash

#: Set up OpenSSH server for Ubuntu.
#: 
#: Intended for Ubuntu 18.04
#: Author: Fastily

sudo apt update && sudo apt -y install openssh-server

## Harden sshd - disallow root login and password auth
SSH_CONFIG="/etc/ssh/sshd_config"

sudo cp "$SSH_CONFIG" "/tmp/" # create temp backup
sudo sed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$SSH_CONFIG"
sudo sed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$SSH_CONFIG"

# sudo systemctl restart ssh

## create config files
mkdir -p ~/.ssh
touch ~/.ssh/authorized_keys