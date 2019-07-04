#!/bin/bash

#: Installs samba
#: 
#: Tested on Ubuntu 18.04.2
#: Author: Fastily

sudo apt update && \
sudo apt -y install samba && \
sudo sed -i 's/^\[global\]/\[global\]\n   usershare owner only = false/' "/etc/samba/smb.conf"