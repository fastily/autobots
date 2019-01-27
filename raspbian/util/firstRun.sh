#!/bin/bash

#: Bootstrap my raspbian installs.  Offer this over the network to a clean install.
#: 
#: Author: Fastily


sudo apt update && \
sudo apt -y upgrade && \
sudo apt -y install git

cd /tmp

git clone --depth 1 'https://github.com/fastily/autobots.git' && \
bash autobots/raspbian/init.sh && \
curl 'https://gist.githubusercontent.com/fastily/4695d2bca65d91958f602bfb8d497def/raw/fd1b441b9f36c620ac0a3f1d9db5cb87b5cd4d3d/pi.pub' >> ~/.ssh/authorized_keys