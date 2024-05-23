#!/bin/bash

#: Configure and set up Ubuntu Server.
#: 
#: Tested on Ubuntu 22.04
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e
source shared.sh

# install dependencies, configure global settings
general_settings
setup_sshd
install_shared_packages

# Install cloudflared
bash ../installers/cloudflared.sh

# Configure firewall
sudo ufw default allow outgoing
sudo ufw default deny incoming
echo "y" | sudo ufw enable

echo "Done, reboot for changes to take effect."