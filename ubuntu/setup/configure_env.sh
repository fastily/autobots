#!/bin/bash

#: Set my preferred bash aliases and create user's bin folder
#: 
#: Tested on Ubuntu 18.04
#: Author: Fastily

## create user bin and aliases
mkdir -p ~/bin

cat << EOF >> ~/".bash_aliases"

alias uuaa="sudo apt update && sudo apt upgrade -y && sudo apt autoclean && sudo apt autoremove -y"
alias uuaar="uuaa && sudo reboot"
EOF

## Apply GUI Settings if possible
if command -v gsettings &> /dev/null; then
	gsettings set org.gnome.desktop.session idle-delay 0
	gsettings set org.gnome.desktop.media-handling autorun-never true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
fi