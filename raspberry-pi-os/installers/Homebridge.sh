#!/bin/bash

#: Installs Homebridge on Raspberry Pi OS
#: 
#: Author: Fastily

curl -sSfL "https://repo.homebridge.io/KEY.gpg" | sudo gpg --dearmor | sudo tee "/usr/share/keyrings/homebridge.gpg" > /dev/null
echo "deb [signed-by=/usr/share/keyrings/homebridge.gpg] https://repo.homebridge.io stable main" | sudo tee "/etc/apt/sources.list.d/homebridge.list" > /dev/null
sudo apt update
sudo apt install homebridge