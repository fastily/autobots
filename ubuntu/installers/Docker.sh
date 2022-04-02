#!/usr/bin/env bash

#: Installs Docker engine & compose.  Adapted from [https://docs.docker.com/engine/install/ubuntu/]
#: 
#: Author: Fastily

# install pre-requisites
sudo apt update && sudo apt -y install ca-certificates curl gnupg lsb-release

# setup apt repo and install docker engine
curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | sudo gpg --dearmor -o "/usr/share/keyrings/docker-archive-keyring.gpg"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee "/etc/apt/sources.list.d/docker.list" > /dev/null
sudo apt update && sudo apt -y install docker-ce docker-ce-cli containerd.io

# allow current user to run docker
#sudo groupadd docker
sudo usermod -a -G docker $(whoami)

# install compose
COMPOSE_PATH="/usr/local/bin/docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o "$COMPOSE_PATH" && sudo chmod +x "$COMPOSE_PATH"