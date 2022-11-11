#!/bin/bash

#: Set my preferred bash aliases and desktop settings
#: 
#: Tested on Ubuntu 18.04
#: Author: Fastily

cat << EOF >> ~/".bash_aliases"

alias uuaa="sudo apt update && sudo apt upgrade -y && sudo apt autoclean && sudo apt autoremove -y"
alias uuaar="uuaa && sleep 5 && sudo reboot"
alias uuaas="uuaa && sleep 5 && sudo shutdown -h now"
EOF

## Apply GUI Settings if possible
if command -v gsettings &> /dev/null; then
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.desktop.media-handling autorun-never true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
fi