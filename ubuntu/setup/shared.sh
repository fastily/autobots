#!/bin/bash

#: Shared functions for ubuntu intializer scripts.
#: 
#: Author: Fastily

##
# Applies general, shared settings.
##
general_settings() {
    # setup bash aliases
    cat << EOF >> ~/".bash_aliases"

alias dcla="docker container ls -a "
alias dlf="docker logs -f --tail 1000 "
alias uuaa="sudo apt update && sudo apt upgrade -y && sudo apt autoclean && sudo apt autoremove -y"
alias uuaar="uuaa && sleep 5 && sudo reboot"
alias uuaas="uuaa && sleep 5 && sudo shutdown now"
EOF

    # suppress irritating apt prompt in >= 22.04
    local NR_CONF="/etc/needrestart/needrestart.conf"
    if [ -f "$NR_CONF" ]; then
        sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' "$NR_CONF"
        sudo sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" "$NR_CONF"
    fi
}

##
# Apply my preferred desktop settings
##
apply_ui_settings() {
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.desktop.media-handling autorun-never true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
}

##
# Setup & configure OpenSSH server
#
# PARAMETERS:
#   $1 - Configure sshd to use an alternative port (i.e. not 22).  Optional - leave blank to disable.
##
setup_sshd() {
    sudo apt-get update && sudo apt-get -y install openssh-server

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