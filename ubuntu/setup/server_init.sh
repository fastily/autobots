#!/bin/bash

#: Configure and set up Ubuntu Server.
#: 
#: Tested on Ubuntu 22.04
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e
source shared.sh

SSH_PORT="41517"

# install dependencies, configure global settings
setup_sshd "$SSH_PORT"
general_settings
sudo apt-get -y install fail2ban net-tools

# Install ssh key
# read -r -p "Enter ssh pubkey: "
# echo "$REPLY" >> ~/.ssh/authorized_keys

# Configure firewall
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow "${SSH_PORT}/tcp"
echo "y" | sudo ufw enable

# create containers
mkdir -p ~/containers

echo "Done, reboot for changes to take effect."