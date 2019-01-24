#!/bin/bash

#: Installs VirtualBox for Ubuntu.  Not 100% automatic, there may be prompts during the installation.
#: Also downloads the extension pack to the user's home directory
#: 
#: Intended for Ubuntu 18.04
#: Author: Fastily

DLURL='https://download.virtualbox.org/virtualbox/6.0.2/virtualbox-6.0_6.0.2-128162~Ubuntu~bionic_amd64.deb'
EXTPACKURL='https://download.virtualbox.org/virtualbox/6.0.2/Oracle_VM_VirtualBox_Extension_Pack-6.0.2.vbox-extpack'
TARGETDIR="/tmp/vboxsetup"

mkdir -p "$TARGETDIR"

cd "$TARGETDIR"
wget "$DLURL"
sudo dpkg -i "$( basename $DLURL )"
sudo apt-get -y -f install

wget -P ~ "$EXTPACKURL"