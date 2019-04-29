#!/bin/bash

#: Script to run on vbox ubuntu guests
#: 
#: Tested on Ubuntu Desktop 18.04
#: Author: Fastily

VBOXVERSION="6.0.6"
ISOFILE="VBoxGuestAdditions_${VBOXVERSION}.iso"
MOUNTDIR="/media/vboxGuestExt"

sudo apt update
sudo apt install -y curl gcc make perl

cd /tmp
wget "https://download.oracle.com/virtualbox/${VBOXVERSION}/${ISOFILE}"

sudo mkdir -p "$MOUNTDIR"
sudo mount -o loop,ro "$ISOFILE" "$MOUNTDIR"
sudo "${MOUNTDIR}/VBoxLinuxAdditions.run"
sudo umount "$MOUNTDIR"
sudo rm -rf "$MOUNTDIR"

sudo adduser $( whoami ) vboxsf

printf "Done!  Please reboot for changes to take effect.\n"