#!/bin/bash

#: Configures apt repo for cloudflared and installs it.  Does not start/configure daemon, you still have to run "sudo cloudflared service install <YOUR_TOKEN>"
#: 
#: Tested on Ubuntu 24.04
#: Author: Fastily

set -e

KEYRINGS="/usr/share/keyrings"
PKG_CF="https://pkg.cloudflare.com"
CF_GPG="cloudflare-main.gpg"
CFD="cloudflared"

sudo mkdir -p --mode=0755 "$KEYRINGS"
curl -fsSL "${PKG_CF}/${CF_GPG}" | sudo tee "${KEYRINGS}/${CF_GPG}" > /dev/null
echo "deb [signed-by=${KEYRINGS}/${CF_GPG}] ${PKG_CF}/${CFD} $(. /etc/os-release && echo "$VERSION_CODENAME") main" | sudo tee "/etc/apt/sources.list.d/${CFD}.list" > /dev/null
sudo apt update
sudo apt install -y "$CFD"