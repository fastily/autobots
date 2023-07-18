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
DOCKER_KEYRING="${KEYRINGS}/docker.gpg"

sudo apt update && sudo apt install -y ca-certificates curl gnupg

sudo install -m 0755 -d "$KEYRINGS"
curl -fsSL "${DOCKER_DL}/gpg" | sudo gpg --dearmor -o "$DOCKER_KEYRING"
sudo chmod +r "$DOCKER_KEYRING"
echo "deb [arch="$(dpkg --print-architecture)" signed-by=${DOCKER_KEYRING}] ${DOCKER_DL} "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker "$USER"