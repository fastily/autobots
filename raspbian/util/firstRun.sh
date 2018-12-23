#!/bin/bash

#: Bootstrap my raspbian installs.  Offer this over the network to a clean install.
#: 
#: Author: Fastily


sudo apt update && \
sudo apt -y upgrade && \
sudo apt -y install git

cd /tmp

git clone --depth 1 'https://github.com/fastily/autobots.git'
bash autobots/raspbian/init.sh