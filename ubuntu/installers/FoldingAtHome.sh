#!/bin/bash

#: Installs the folding@home client on ubuntu. Source: https://foldingathome.org/alternative-downloads/
#: 
#: Author: Fastily

cd /tmp

debFile="fahclient_7.6.9_amd64.deb"

wget 'https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.6/${debFile}'
sudo dpkg -i "$debFile"
sudo apt-get install -f -y