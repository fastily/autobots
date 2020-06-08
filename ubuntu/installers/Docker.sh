#!/bin/bash

#: Installs Docker from their apt repo
#: 
#: Tested on Ubuntu Desktop 18.04.4
#: Author: Fastily

sudo apt update && sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update && sudo apt -y install docker-ce docker-ce-cli containerd.io

# allow current user to run docker
sudo usermod -a -G docker $(whoami)

# docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose