#!/bin/bash

#: Installs VirtualBox for Ubuntu.  Not 100% automatic, there may be prompts during the installation.
#: Also downloads the extension pack to the user's home directory
#: 
#: Intended for Ubuntu 18.04
#: Author: Fastily

# install virtualbox
printf "deb https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib\n" | sudo tee -a "/etc/apt/sources.list" > /dev/null
wget -q 'https://www.virtualbox.org/download/oracle_vbox_2016.asc' -O - | sudo apt-key add -
wget -q 'https://www.virtualbox.org/download/oracle_vbox.asc' -O - | sudo apt-key add -

sudo apt update && sudo apt install -y virtualbox-6.1

# install extension pack
VBOXVERSION=$(wget -q -O - "https://download.virtualbox.org/virtualbox/LATEST.TXT")
EXTPACKFILE="Oracle_VM_VirtualBox_Extension_Pack-${VBOXVERSION}.vbox-extpack"

cd /tmp
wget "https://download.virtualbox.org/virtualbox/${VBOXVERSION}/${EXTPACKFILE}"

sudo vboxmanage extpack install --replace "$EXTPACKFILE"