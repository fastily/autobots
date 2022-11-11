#!/bin/bash

#: Configure and set up Ubuntu Server.
#: 
#: Tested on Ubuntu Desktop 22.04
#: Author: Fastily

cd "${0%/*}" &> /dev/null

set -e

# install dependencies, configure global settings
bash base_settings.sh
bash ../installers/OpenSSH.sh
sudo apt -y install fail2ban

# Install ssh key
read -r -p "Enter ssh pubkey: "
echo "$REPLY" >> ~/.ssh/authorized_keys

# Configure firewall
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
echo "y" | sudo ufw enable

echo "Done, reboot for changes to take effect."