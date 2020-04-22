#!/bin/bash

#: Setup PIA VPN for Ubuntu.
#: 
#: Intended for Ubuntu 18.04
#: Author: Fastily

OUTDIR="/tmp/PIA"

sudo apt update && sudo apt install -y curl network-manager-openvpn-gnome && \
wget 'https://www.privateinternetaccess.com/installer/pia-nm.sh' -P "$OUTDIR" && \
sudo bash "${OUTDIR}/pia-nm.sh"

printf "Done!\n"