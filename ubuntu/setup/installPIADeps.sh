#!/bin/bash

#: Downloads and install dependencies for the PIA UI client. This isn't 
#: gaunrateed to be 100% automatic; you may be prompted for input or with confirm dialogs.
#: This DOES NOT install PIA, to install PIA, download the installer here:
#: [https://www.privateinternetaccess.com/pages/downloads]
#: 
#: Must be run as root.
#: 
#: Tested on Ubuntu Server 16.04.  
#: Author: Fastily

cd "${0%/*}"
source ../../shared/autobotUtils.sh
confirmRunAsRoot

printf "Installing PIA dependencies\n"

cd ~

wget "https://launchpad.net/%7Eubuntu-security-proposed/+archive/ubuntu/ppa/+build/7110687/+files/libgcrypt11_1.5.4-2ubuntu1.1_amd64.deb"
dpkg -i "libgcrypt11_1.5.4-2ubuntu1.1_amd64.deb"

wget "http://ubuntu.cs.utah.edu/ubuntu/pool/main/libt/libtasn1-3/libtasn1-3_2.10-1ubuntu1.5_amd64.deb"
dpkg -i "libtasn1-3_2.10-1ubuntu1.5_amd64.deb"

wget "http://ubuntu.cs.utah.edu/ubuntu/pool/main/g/gnutls26/libgnutls26_2.12.14-5ubuntu3.12_amd64.deb"
dpkg -i "libgnutls26_2.12.14-5ubuntu3.12_amd64.deb"

apt-get install -f

apt-get install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev

printf "Done!\n"