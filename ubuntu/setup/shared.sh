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

    # default apt to keeping user's config files
    sudo tee "/etc/apt/apt.conf.d/99z-my-settings" > /dev/null << EOF
Dpkg::Options {
   "--force-confdef";
   "--force-confold";
}
EOF

    # max # of open file descriptors is egregiously low
    local f_hard_limit=1048576
    local f_soft_limit=65536
    local limit_d="/etc/security/limits.d"

    sudo mkdir -p "$limit_d" /etc/systemd/{system,user}.conf.d

    sudo tee "${limit_d}/99my_custom.conf" > /dev/null << EOF
* soft nofile ${f_soft_limit}
* hard nofile ${f_hard_limit}
root soft nofile ${f_soft_limit}
root hard nofile ${f_hard_limit}
EOF

    for f in /etc/systemd/{system,user}.conf.d/99my_custom.conf; do
        sudo tee "$f" > /dev/null << EOF
[Manager]
DefaultLimitNOFILE=${f_soft_limit}:${f_hard_limit}
EOF
    done

    for f in /etc/pam.d/common-session{,-noninteractive}; do
        echo "session required pam_limits.so" | sudo tee -a "$f" > /dev/null
    done

    # suppress irritating apt prompt in >= 22.04
    local NR_CONF="/etc/needrestart/needrestart.conf"
    if [[ -f $NR_CONF ]]; then
        sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' "$NR_CONF"
        sudo sed -i "s/#\$nrconf{kernelhints} = -1;/\$nrconf{kernelhints} = -1;/g" "$NR_CONF"
    fi

    # create user's home bin & containers
    mkdir -p ~/{bin,containers} ~/.config/containers

    # update apt lists
    sudo apt-get update
}

##
# Apply my preferred desktop settings
##
apply_ui_settings() {
    gsettings set org.gnome.desktop.session idle-delay 0
    gsettings set org.gnome.desktop.media-handling autorun-never true
    gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true

    if (( $(lsb_release -rs | tr -d ".") >= 2204 )); then
        gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
        gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    fi
}

##
# Setup & configure OpenSSH server
#
# PARAMETERS:
#   $1 - Configure sshd to use an alternative port (i.e. not 22).  Optional - leave blank to disable.
##
setup_sshd() {
    sudo apt-get -y install openssh-server

    local SSH_CONFIG="/etc/ssh/sshd_config"
    cp "$SSH_CONFIG" "/tmp/"
    sudo sed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$SSH_CONFIG"
    sudo sed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$SSH_CONFIG"

    if [[ -n $1 ]]; then
        sudo sed -i -E "s/^\#?Port .*/Port ${1}/" "$SSH_CONFIG"
    fi

    mkdir -p ~/.ssh
    touch ~/.ssh/authorized_keys
}

##
# Setup nfs service
##
setup_nfs() {
    sudo apt -y install nfs-kernel-server
    sudo systemctl start nfs-kernel-server.service
}

##
# Instlls global shared packages
##
install_shared_packages() {
    sudo apt-get install -y fail2ban jq net-tools
}