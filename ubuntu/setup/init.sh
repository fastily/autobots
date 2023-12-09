#!/bin/bash

#: Install some helpful packages and apply sane settings for Ubuntu Server/Desktop.
#: 
#: Tested on Ubuntu Desktop 22.04.1
#: Author: Fastily

cd "${0%/*}" &> /dev/null
set -e
source shared.sh

# install dependencies, configure global settings
setup_sshd
apply_ui_settings
general_settings
sudo apt -y install exfat-fuse exfatprogs fail2ban hfsprogs iperf3 jq net-tools nfs-kernel-server screen smartmontools

# Configure file limits
# MAX_FILES_OPEN=131072
# sudo tee -a "/etc/security/limits.conf" > /dev/null <<EOF

# * - nofile ${MAX_FILES_OPEN}
# root - nofile ${MAX_FILES_OPEN}
# EOF

# for target in /etc/pam.d/common-session*; do
#     echo "session required pam_limits.so" | sudo tee -a "$target" > /dev/null
# done

# ulimit -n "$MAX_FILES_OPEN"

# Start nfs service
sudo systemctl start nfs-kernel-server.service

# create user's home bin & containers
mkdir -p ~/{bin,containers}

echo "Done, reboot for changes to take effect."