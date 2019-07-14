#!/bin/bash

#: Install some helpful packages and apply sane settings for Ubuntu Server/Desktop.
#: 
#: Tested on Ubuntu Desktop 18.04.2
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Install packages
sudo apt update && \
sudo apt -y install curl exfat-fuse exfat-utils fail2ban hfsprogs net-tools openssh-client openssh-server screen

## Install Samba
bash ../installers/Samba.sh

## Apply custom settings for ssh
sshdConfig="/etc/ssh/sshd_config"
sudo cp "$sshdConfig" "${sshdConfig}_BACKUP.txt" # create backup
sudo sed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$sshdConfig"
sudo sed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$sshdConfig"
sudo service sshd restart

## configure ssh, user bin, and aliases
mkdir -p ~/.ssh ~/bin
touch ~/.ssh/authorized_keys

printf '\nalias uuu="sudo apt update && sudo apt upgrade -y"' >> ~/.bash_aliases
printf '\nalias aaa="sudo apt autoclean && sudo apt autoremove -y"' >> ~/.bash_aliases

## Apply GUI Settings if possible
if hash gsettings 2>/dev/null; then
	gsettings set org.gnome.desktop.session idle-delay 0
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
	gsettings set org.gnome.desktop.media-handling autorun-never true
fi

printf "Done!\n"