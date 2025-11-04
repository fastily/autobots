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
APT_SOURCE_LIST="/etc/apt/sources.list.d"

sudo apt update
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d "$KEYRINGS"
sudo curl -fsSL "${DOCKER_DL}/gpg" -o "$KEY_FILE"
sudo chmod a+r "$KEY_FILE"

if [[ $OS_ID == "debian" ]]; then
    sudo tee "${APT_SOURCE_LIST}/docker.sources" > /dev/null << EOF
Types: deb
URIs: ${DOCKER_DL}
Suites: $(. "$OSR" && echo "$VERSION_CODENAME")
Components: stable
Signed-By: ${KEY_FILE}
EOF
else
    echo "deb [arch=$(dpkg --print-architecture) signed-by=${KEY_FILE}] ${DOCKER_DL} $(. "$OSR" && echo "${UBUNTU_CODENAME:-VERSION_CODENAME}") stable" | sudo tee "${APT_SOURCE_LIST}/docker.list" > /dev/null
fi

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo usermod -aG docker "$USER"