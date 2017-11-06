#!/bin/bash

#: Script to run on vbox ubuntu guests
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

cd "${0%/*}" &> /dev/null
source ../../shared/autobotUtils.sh
confirmRunAsRoot

adduser $( whoami ) vboxsf
bash ./hideGuest.sh

printf "Done!  Please reboot to see changes.\n"