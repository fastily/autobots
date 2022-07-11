#!/bin/bash

#: Installs Samba
#: 
#: Author: Fastily

sudo apt update && sudo apt install -y samba samba-common-bin

sudo sed -i '/\[global\]/a server min protocol = NT1"' "/etc/samba/smb.conf" # Enables SMB1, yeah I know this is terrible