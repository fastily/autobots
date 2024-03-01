#!/bin/bash

#: Install some helpful packages and apply sane settings for Ubuntu Server.
#: 
#: Tested on Ubuntu Desktop 22.04.4
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e
source shared.sh

general_settings
install_shared_packages
setup_sshd
setup_nfs
sudo apt install -y screen smartmontools

echo "Done, reboot for changes to take effect."