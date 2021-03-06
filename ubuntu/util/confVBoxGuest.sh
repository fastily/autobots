#!/bin/bash

#: Script to run on vbox ubuntu guests
#: 
#: Tested on Ubuntu Desktop 18.04
#: Author: Fastily

VBOXVERSION=$(wget -q -O - "https://download.virtualbox.org/virtualbox/LATEST.TXT")
ISOFILE="VBoxGuestAdditions_${VBOXVERSION}.iso"
MOUNTDIR="/media/vboxGuestExt"

## Apply GUI Settings if possible
if hash gsettings 2>/dev/null; then
	gsettings set org.gnome.desktop.session idle-delay 0
	gsettings set org.gnome.desktop.media-handling autorun-never true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
fi

## apply configuration
cd "${0%/*}" &> /dev/null
bash confEnv.sh

## install and configure vbox guest additions
sudo apt update
sudo apt install -y curl gcc make perl

cd /tmp
wget "https://download.virtualbox.org/virtualbox/${VBOXVERSION}/${ISOFILE}"

sudo mkdir -p "$MOUNTDIR"
sudo mount -o loop,ro "$ISOFILE" "$MOUNTDIR"
sudo "${MOUNTDIR}/VBoxLinuxAdditions.run"
sudo umount "$MOUNTDIR"
sudo rm -rf "$MOUNTDIR"

sudo adduser $( whoami ) vboxsf

printf "Done!  Please reboot for changes to take effect.\n"