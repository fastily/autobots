#!/bin/bash

#: Configure and set up Ubuntu Server.
#: 
#: Tested on Ubuntu 22.04
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e
source shared.sh

SSH_PORT=41517

# install dependencies, configure global settings
general_settings
setup_sshd "$SSH_PORT"
install_shared_packages

# Configure firewall
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow "${SSH_PORT}/tcp"
echo "y" | sudo ufw enable

echo "Done, reboot for changes to take effect."