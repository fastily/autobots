#!/bin/bash

#: Apply settings for my development Ubuntu server box.  Installs WiFi drivers.  This isn't 
#: gaunrateed to be 100% automatic; you may be prompted for input or with confirm dialogs.
#: Must be run as root.
#: 
#: Tested on Ubuntu Server 15.10.  
#: Author: Fastily

if [ "$EUID" -ne 0 ]; then
	printf "[ERROR]: Script must be run as root (sudo)\n"
	exit
fi

## Install Broadcom wifi drivers
printf "Installing software\n"
apt-get update
apt-get -y install bcmwl-kernel-source


printf "Done!\n"