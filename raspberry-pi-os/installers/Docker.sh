#!/bin/bash

#: Installs Docker on Raspberry Pi OS.  Adapted from [https://docs.docker.com/engine/install/debian/]
#:
#: PRECONDITION:
#:      $1 - Must be using 64-bit Raspberry Pi OS
#: 
#: Author: Fastily

set -e

DOCKER_DL="https://download.docker.com/linux/debian"
KEYRINGS="/etc/apt/keyrings"
KEY_FILE="${KEYRINGS}/docker.asc"

sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d "$KEYRINGS"
sudo curl -fsSL "${DOCKER_DL}/gpg" -o "$KEY_FILE"
sudo chmod +r "$KEY_FILE"

echo "deb [arch=$(dpkg --print-architecture) signed-by=${KEY_FILE}] ${DOCKER_DL} $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker "$USER"