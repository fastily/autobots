#!/bin/bash

#: Setup PIA VPN for Ubuntu.
#: 
#: Intended for Ubuntu 16.04.4
#: Author: Fastily

OUTDIR="/tmp/PIA"

sudo apt install curl network-manager-openvpn-gnome && \
wget 'https://www.privateinternetaccess.com/installer/pia-nm.sh' -P "$OUTDIR" && \
sudo bash "${OUTDIR}/pia-nm.sh"

printf "Done!\n"