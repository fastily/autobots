#!/bin/bash

#: Installs additional applications Calibre and VirtualBox (with all add-ons). 
#:
#: Tested on Ubuntu Server 16.10.
#: Author: Fastily


cd "${0%/*}" &> /dev/null
source ../../shared/autobotUtils.sh
confirmRunAsRoot

apt-get update

printf "Installing Calibre\n"
apt-get -y install calibre

printf "Installing VirtualBox\n"
apt-get -y install virtualbox virtualbox-dkms virtualbox-ext-pack virtualbox-guest-additions-iso \
       virtualbox-guest-dkms virtualbox-guest-source virtualbox-guest-utils virtualbox-guest-x11

printf "Done!\n"