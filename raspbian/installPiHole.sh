#!/bin/bash

#: Installs pi-hole (https://pi-hole.net) on Raspbian.
#: 
#: Author: Fastily

cd /tmp && \
git clone --depth 1 "https://github.com/pi-hole/pi-hole.git" && \
sudo bash "pi-hole/automated install/basic-install.sh"