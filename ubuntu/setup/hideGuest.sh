#!/bin/bash

#: Hides Guest account from login screen.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

cd "${0%/*}" &> /dev/null
source ../../shared/autobotUtils.sh
confirmRunAsRoot

LIGHTDM="/etc/lightdm"

mkdir -p "$LIGHTDM"

cat > "${LIGHTDM}"/lightdm.conf <<- EOM
	[SeatDefaults]
	user-session=ubuntu
	greeter-session=unity-greeter
	allow-guest=false

EOM