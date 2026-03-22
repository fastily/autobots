#!/bin/bash

#: Configures apt repo for cloudflared and installs it
#: 
#: Tested on Ubuntu 24.04
#: Author: Fastily

set -e

PKG_CF="https://pkg.cloudflare.com"
CF_GPG="cloudflare-public-v2.gpg"
KEYRINGS="/usr/share/keyrings"
CF_GPG_PATH="${KEYRINGS}/${CF_GPG}"
CFD="cloudflared"

sudo mkdir -p --mode=0755 "$KEYRINGS"
curl -fsSL "${PKG_CF}/${CF_GPG}" | sudo tee "$CF_GPG_PATH" > /dev/null
echo "deb [signed-by=${CF_GPG_PATH}] ${PKG_CF}/${CFD} any main" | sudo tee "/etc/apt/sources.list.d/${CFD}.list" > /dev/null

sudo apt update
sudo apt install -y "$CFD"

read -p "Enter Cloudflare token: " MY_CF_TOKEN
sudo "$CFD" service install "$MY_CF_TOKEN"
systemctl status cloudflared --no-pager