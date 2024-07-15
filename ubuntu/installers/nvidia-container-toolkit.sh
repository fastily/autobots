#!/usr/bin/env bash

#: Installs the nvidia container toolkit [https://github.com/NVIDIA/nvidia-container-toolkit]
#:
#: PRECONDITIONS:
#:    1) Docker is installed
#:    2) Nvidia drivers (from ./nvidia-driver.sh) are installed
#:
#: Tested on Ubuntu 22.04
#: Author: Fastily

set -e

LIBNVIDIA_URL="https://nvidia.github.io/libnvidia-container"

curl -fsSL "${LIBNVIDIA_URL}/gpgkey" | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -sL "${LIBNVIDIA_URL}/stable/deb/nvidia-container-toolkit.list" | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt update
sudo apt install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=docker

echo "All set, reboot for changes to take effect!"