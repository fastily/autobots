#!/bin/bash

#: Installs the UniFi Controller.  Inspired by [https://community.ubnt.com/t5/UniFi-Routing-Switching/Step-By-Step-Tutorial-Guide-Raspberry-Pi-with-UniFi-controller/td-p/2470231]
#:
#: PRECONDITION:
#:		1) java 8 or better is installed
#: 
#: Author: Fastily

cd /tmp

wget 'https://dl.ubnt.com/unifi/5.10.20/unifi_sysvinit_all.deb'
sudo dpkg -i unifi_sysvinit_all.deb
sudo apt-get install -f -y