#!/bin/bash

#: Installs VirtualBox for Ubuntu.  Not 100% automatic, there may be prompts during the installation.
#: Also downloads the extension pack to the user's home directory
#: 
#: Intended for Ubuntu 18.04
#: Author: Fastily

# DLURL='https://download.virtualbox.org/virtualbox/6.0.6/virtualbox-6.0_6.0.6-130049~Ubuntu~bionic_amd64.deb'
# EXTPACKURL='https://download.virtualbox.org/virtualbox/6.0.6/Oracle_VM_VirtualBox_Extension_Pack-6.0.6.vbox-extpack'
# TARGETDIR="/tmp/vboxsetup"

# mkdir -p "$TARGETDIR"

# cd "$TARGETDIR"
# wget "$DLURL"
# sudo dpkg -i "$( basename $DLURL )"
# sudo apt-get -y -f install

# wget -P ~ "$EXTPACKURL"


printf "deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib\n" | sudo tee -a "/etc/apt/sources.list" > /dev/null
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

sudo apt update && sudo apt install -y virtualbox-6.0