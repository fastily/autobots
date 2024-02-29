#!/bin/bash

#: Install some helpful packages and apply sane settings for Ubuntu Desktop.
#: 
#: Tested on Ubuntu Desktop 22.04.1
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e
source shared.sh

general_settings
apply_ui_settings
install_shared_packages
setup_sshd
setup_nfs
sudo apt -y install exfat-fuse exfatprogs hfsprogs iperf3 screen smartmontools

echo "Done, reboot for changes to take effect."