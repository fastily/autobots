#!/usr/bin/env bash

#: Installs Docker engine & compose.  Adapted from [https://docs.docker.com/engine/install/ubuntu/]
#: 
#: Author: Fastily

# install pre-requisites
sudo apt-get update && sudo apt-get -y install ca-certificates curl gnupg lsb-release

# setup apt repo and install docker engine
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo gpg --dearmor -o "/etc/apt/keyrings/docker.gpg"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee "/etc/apt/sources.list.d/docker.list" > /dev/null
sudo apt-get update && sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# allow current user to run docker
sudo usermod -aG docker "$USER"