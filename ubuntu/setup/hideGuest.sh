#!/bin/bash

#: Applies settings to hide guest account from login screen.
#: 
#: Tested on Ubuntu Desktop 16.04.3
#: Author: Fastily

LIGHTDM="/etc/lightdm"

mkdir -p "$LIGHTDM"

printf "[SeatDefaults]
user-session=ubuntu
greeter-session=unity-greeter
allow-guest=false\n" | sudo tee -a "${LIGHTDM}/lightdm.conf" > /dev/null