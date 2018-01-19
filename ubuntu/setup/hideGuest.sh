#!/bin/bash

#: Hides Guest account from login screen.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

cd "${0%/*}" &> /dev/null

LIGHTDM="/etc/lightdm"
sudo mkdir -p "$LIGHTDM"

sudo cat > "${LIGHTDM}"/lightdm.conf <<- EOM
	[SeatDefaults]
	user-session=ubuntu
	greeter-session=unity-greeter
	allow-guest=false

EOM