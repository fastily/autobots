#!/usr/bin/env bash

#: Set up apt repo for UniFi Controller.  Adapted from [https://help.ui.com/hc/en-us/articles/220066768-UniFi-Network-How-to-Install-and-Update-via-APT-on-Debian-or-Ubuntu]
#: 
#: Author: Fastily

sudo apt update && sudo apt install -y ca-certificates apt-transport-https
echo 'deb https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee "/etc/apt/sources.list.d/100-ubnt-unifi.list"
sudo wget -O "/etc/apt/trusted.gpg.d/unifi-repo.gpg" "https://dl.ui.com/unifi/unifi-repo.gpg"
sudo apt update && sudo apt install -y unifi