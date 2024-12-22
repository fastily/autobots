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

# shut up passowrd manager, nobody cares
CFG_FILE="share/applications/google-chrome.desktop"
LOCALCONFIG=~/".local/${CFG_FILE}"
cp "/usr/${CFG_FILE}" "$LOCALCONFIG"
sed -i -e 's|google-chrome-stable|google-chrome-stable --password-store=basic|' "$LOCALCONFIG"