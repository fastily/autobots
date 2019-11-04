#!/bin/bash

#: Install barebones utilities for Ubuntu Server/Desktop.
#: 
#: Tested on Ubuntu Desktop 18.04
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Install packages
sudo apt update && sudo apt -y install curl exfat-fuse exfat-utils fail2ban hfsprogs net-tools screen

## Install OpenSSH
bash ../installers/OpenSSH.sh

## Configure ~/bin and aliases
bash ../util/confEnv.sh

## Apply GUI Settings if possible
if hash gsettings 2>/dev/null; then
	gsettings set org.gnome.desktop.session idle-delay 0
	gsettings set org.gnome.desktop.media-handling autorun-never true
fi

printf "Done!\n"