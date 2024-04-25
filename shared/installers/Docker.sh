#!/usr/bin/env bash

#: Installs Docker engine & compose.  Adapted from [https://docs.docker.com/engine/install/ubuntu/]
#: 
#: PRECONDITION:
#:      1) Must be using debian, 64-bit Raspberry Pi OS, or ubuntu
#:
#: Author: Fastily

set -e

OSR="/etc/os-release"
OS_ID="$( . "$OSR" && echo "$ID" )"
case "$OS_ID" in
    ubuntu|debian)
        echo "Installing Docker for ${OS_ID}..."
        ;;
    *)
        echo "${OS_ID} is not a supported OS, abort"
        exit 1
        ;;
esac

DOCKER_DL="https://download.docker.com/linux/${OS_ID}"
KEYRINGS="/etc/apt/keyrings"
KEY_FILE="${KEYRINGS}/docker.asc"

sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d "$KEYRINGS"
sudo curl -fsSL "${DOCKER_DL}/gpg" -o "$KEY_FILE"
sudo chmod +r "$KEY_FILE"

echo "deb [arch=$(dpkg --print-architecture) signed-by=${KEY_FILE}] ${DOCKER_DL} $(. "$OSR" && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker "$USER"