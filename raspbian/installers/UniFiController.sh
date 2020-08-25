#!/bin/bash

#: Installs the UniFi Controller.  Inspired by [https://community.ubnt.com/t5/UniFi-Routing-Switching/Step-By-Step-Tutorial-Guide-Raspberry-Pi-with-UniFi-controller/td-p/2470231]
#:
#: PRECONDITION:
#:		1) java 8 or better is installed
#: 
#: Author: Fastily

sudo apt update && sudo apt install -y haveged openjdk-8-jre-headless

cd /tmp

wget 'https://dl.ui.com/unifi/5.14.22/unifi_sysvinit_all.deb'
sudo dpkg -i unifi_sysvinit_all.deb
sudo apt-get install -f -y