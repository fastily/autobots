#!/bin/bash

#: Installs VirtualBox for Ubuntu 16.04.4.  Not 100% automatic, there may be prompts during the installation.
#: Also downloads the extension pack to the user's home directory
#: 
#: Intended for Ubuntu 16.04.4
#: Author: Fastily

DLURL='https://download.virtualbox.org/virtualbox/5.2.14/virtualbox-5.2_5.2.14-123301~Ubuntu~xenial_amd64.deb'
EXTPACKURL='https://download.virtualbox.org/virtualbox/5.2.14/Oracle_VM_VirtualBox_Extension_Pack-5.2.14.vbox-extpack'

FILENAME="$( basename $DLURL )"
TARGETDIR="/tmp/vboxsetup"
mkdir -p "$TARGETDIR"

cd "$TARGETDIR"
wget "$DLURL"
sudo dpkg -i "$FILENAME"
sudo apt-get -y -f install

wget -P ~ "$EXTPACKURL"