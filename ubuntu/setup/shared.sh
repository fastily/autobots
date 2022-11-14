#!/bin/bash

#: Shared functions for ubuntu intializer scripts.
#: 
#: Author: Fastily

##
# Installs bash aliases
##
setup_bash_aliases() {
    cat << EOF >> ~/".bash_aliases"

alias uuaa="sudo apt update && sudo apt upgrade -y && sudo apt autoclean && sudo apt autoremove -y"
alias uuaar="uuaa && sleep 5 && sudo reboot"
alias uuaas="uuaa && sleep 5 && sudo shutdown -h now"
EOF
}

##
# Apply my preferred desktop settings
##
apply_ui_settings() {
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.desktop.media-handling autorun-never true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
}

##
# Setup & configure OpenSSH server
#
# PARAMETERS:
#   $1 - Configure sshd to use an alternative port (i.e. not 22).  Optional - leave blank to disable.
##
setup_sshd() {
    sudo apt update && sudo apt -y install openssh-server

    local SSH_CONFIG="/etc/ssh/sshd_config"
    cp "$SSH_CONFIG" "/tmp/"
    sudo sed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$SSH_CONFIG"
    sudo sed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$SSH_CONFIG"

    if [ ! -z "$1" ]; then
        sudo sed -i -E "s/^\#?Port .*/Port ${1}/" "$SSH_CONFIG"
    fi

    mkdir -p ~/.ssh
    touch ~/.ssh/authorized_keys
}