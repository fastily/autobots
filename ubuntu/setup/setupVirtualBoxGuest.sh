#!/bin/bash

#: Script to run on vbox ubuntu guests
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

cd "${0%/*}" &> /dev/null

sudo adduser $( whoami ) vboxsf
# sudo bash ./hideGuest.sh

printf "Done!  Please reboot for changes to take effect.\n"