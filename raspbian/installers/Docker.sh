#!/bin/bash

#: Installs Docker on Raspbian.  Adapted from [https://docs.docker.com/install/linux/docker-ce/debian/#install-using-the-convenience-script]
#: 
#: Author: Fastily

SCRIPTNAME="get-docker.sh"

cd /tmp
wget -O "$SCRIPTNAME" "https://get.docker.com" && \
sudo sh "$SCRIPTNAME"

sudo usermod -aG docker "$(whoami)"

printf "Done! Reboot for changes to take effect\n"