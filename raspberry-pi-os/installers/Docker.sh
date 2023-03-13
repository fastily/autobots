#!/bin/bash

#: Installs Docker on Raspberry Pi OS.  Adapted from [https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script]
#: 
#: Author: Fastily

SCRIPT_NAME="get-docker.sh"

cd /tmp
curl -fsSL "https://get.docker.com" -o "$SCRIPT_NAME"
sudo sh "$SCRIPT_NAME"

sudo usermod -aG docker "$USER"