#!/usr/bin/env bash

#: Installs Caddy server on Raspberry pi OS
#: 
#: Author: Fastily

set -e

sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o '/usr/share/keyrings/caddy-stable-archive-keyring.gpg'
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee '/etc/apt/sources.list.d/caddy-stable.list'
sudo apt update 
sudo apt install -y caddy