#!/usr/bin/env bash

#: Installs latest version of chrome
#: 
#: Author: Fastily

DEB_FILE="google-chrome-stable_current_amd64.deb"

cd /tmp

wget "https://dl.google.com/linux/direct/${DEB_FILE}"
sudo apt install -y "./${DEB_FILE}"

if systemctl status display-manager &> /dev/null; then # shut up passowrd manager on headed ubuntu
    CFG_FILE="share/applications/google-chrome.desktop"
    LOCALCONFIG=~/".local/${CFG_FILE}"
    cp "/usr/${CFG_FILE}" "$LOCALCONFIG"
    sed -i -e 's|google-chrome-stable|google-chrome-stable --password-store=basic|' "$LOCALCONFIG"
fi