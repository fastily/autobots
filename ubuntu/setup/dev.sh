#!/bin/bash

#: Apply settings for my development Ubuntu server box.  Installs WiFi drivers.  This isn't 
#: gaunrateed to be 100% automatic; you may be prompted for input or with confirm dialogs.
#: Must be run as root.
#: 
#: Tested on Ubuntu Server 15.10.  
#: Author: Fastily

cd `dirname "$0"`
source ../../shared/autobotUtils.sh
confirmRunAsRoot

## Set working directory to user's home
cd ~

## Install Broadcom wifi drivers
printf "[INFO]: Installing Broadcom WiFI Drivers\n"
apt-get update
apt-get -y install bcmwl-kernel-source


## Install PIA
printf "[INFO]: Installing PIA\n"
wget "https://www.privateinternetaccess.com/installer/install_ubuntu.sh"
chmod a+x install_ubuntu.sh
./install_ubuntu.sh

printf "Cleaning up\n"
rm install_ubuntu.sh

printf "Done!\n"
printf "Note: You may have to reboot for changes to take effect.\n"