#!/bin/bash

#: Installs latest version of chrome
#: 
#: Tested on Ubuntu Desktop 18.04
#: Author: Fastily

DEB_FILE="google-chrome-stable_current_amd64.deb"

cd /tmp

wget "https://dl.google.com/linux/direct/${DEB_FILE}" && \
sudo dpkg -i "$DEB_FILE" && \
sudo apt-get install -f