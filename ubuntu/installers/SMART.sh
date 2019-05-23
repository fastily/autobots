#!/bin/bash

#: Installs SMART monitoring tools
#: 
#: Tested on Ubuntu 18.04
#: Author: Fastily

sudo apt update && sudo apt -y install smartmontools gsmartcontrol

printf "Done! Reboot to apply settings\n"