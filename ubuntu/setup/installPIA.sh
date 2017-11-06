#!/bin/bash

#: Setup PIA VPN for Ubuntu.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

cd "${0%/*}" &> /dev/null
source ../../shared/autobotUtils.sh
confirmRunAsRoot

OUTDIR="/tmp"

apt install curl network-manager-openvpn-gnome
wget https://www.privateinternetaccess.com/installer/pia-nm.sh -P "$OUTDIR"
bash "${OUTDIR}/pia-nm.sh"

printf "Done!\n"