#!/bin/bash

#: Set my preferred bash aliases and create user's bin folder
#: 
#: Tested on Ubuntu 18.04
#: Author: Fastily

## create user bin and aliases
mkdir -p ~/bin
printf '\nalias uuaa="sudo apt update && sudo apt upgrade -y && sudo apt autoclean && sudo apt autoremove -y"' >> ~/.bash_aliases

## Apply GUI Settings if possible
if hash gsettings 2>/dev/null; then
	gsettings set org.gnome.desktop.session idle-delay 0
	gsettings set org.gnome.desktop.media-handling autorun-never true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
fi