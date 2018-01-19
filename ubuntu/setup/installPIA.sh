#!/bin/bash

#: Setup PIA VPN for Ubuntu.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

OUTDIR="/tmp/PIA"

sudo apt install curl network-manager-openvpn-gnome && \
wget 'https://www.privateinternetaccess.com/installer/pia-nm.sh' -P "$OUTDIR" && \
sudo bash "${OUTDIR}/pia-nm.sh"

printf "Done!\n"