#!/usr/bin/env bash

#: Shared functions for ubuntu intializer scripts.
#: 
#: Author: Fastily

##
# Applies general, shared settings.
##
general_settings() {
    # update apt lists & set up git
    sudo apt update
    sudo apt install -y git
    git config --global credential.helper store

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

    # suppress irritating apt prompt in 22.04
    local NR_CONF="/etc/needrestart/conf.d"
    if [[ -d $NR_CONF ]]; then
        sudo tee "${NR_CONF}/10-my-needrestart.conf" > /dev/null << 'EOF'
$nrconf{restart} = 'l';
$nrconf{kernelhints} = -1;
EOF
    fi

    # create user's home bin & containers
    mkdir -p ~/{.local/bin,bin,containers,.config/containers}

    # setup local env vars
    local global_sh=~/".config/containers/global.sh"
    printf "\n[[ -r '%s' ]] && source '%s'\n" "$global_sh" "$global_sh" >> ~/.bashrc

    # deploy scripts & bash aliases
    bash ../scripts/deploy.sh
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
##
setup_sshd() {
    sudo apt install -y openssh-server

    local SSH_CONFIG="/etc/ssh/sshd_config.d/10-my-ssh.conf"
    sudo tee "$SSH_CONFIG" > /dev/null << EOF
PermitRootLogin no
PasswordAuthentication no
EOF

    mkdir -p ~/.ssh
    touch ~/.ssh/authorized_keys
}

##
# Setup nfs service
##
setup_nfs() {
    sudo apt install -y nfs-kernel-server
    sudo systemctl start nfs-kernel-server.service
}

##
# Instlls global shared packages
##
install_shared_packages() {
    sudo apt install -y fail2ban jq net-tools
}