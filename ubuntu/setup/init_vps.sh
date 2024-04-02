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
KEYRINGS="/usr/share/keyrings"
PKG_CF="https://pkg.cloudflare.com"
CF_GPG="cloudflare-main.gpg"
CFD="cloudflared"

sudo mkdir -p --mode=0755 "$KEYRINGS"
curl -fsSL "${PKG_CF}/${CF_GPG}" | sudo tee "${KEYRINGS}/${CF_GPG}" > /dev/null
echo "deb [signed-by=${KEYRINGS}/${CF_GPG}] ${PKG_CF}/${CFD} $(. /etc/os-release && echo "$VERSION_CODENAME") main" | sudo tee "/etc/apt/sources.list.d/${CFD}.list" > /dev/null
sudo apt update
sudo apt install -y "$CFD"

# Configure firewall
sudo ufw default allow outgoing
sudo ufw default deny incoming
echo "y" | sudo ufw enable

echo "Done, reboot for changes to take effect."