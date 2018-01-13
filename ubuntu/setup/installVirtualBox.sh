#!/bin/bash

#: Installs VirtualBox for Ubuntu 16.04.3.  Not 100% automatic, there may be prompts during the installation.
#: Also downloads the extension pack to the same directory as the installation files.
#: 
#: Tested on Ubuntu 16.04.3.
#: Author: Fastily

DLURL='http://download.virtualbox.org/virtualbox/5.2.4/virtualbox-5.2_5.2.4-119785~Ubuntu~xenial_amd64.deb'
EXTPACKURL='http://download.virtualbox.org/virtualbox/5.2.4/Oracle_VM_VirtualBox_Extension_Pack-5.2.4-119785.vbox-extpack'

FILENAME="$( basename $DLURL )"
TARGETDIR="/tmp/vboxsetup"
mkdir -p "$TARGETDIR"

cd "$TARGETDIR" && \
wget "$DLURL" && \
sudo dpkg -i "FILENAME" && \
sudo apt-get install -f

wget "$EXTPACKURL"