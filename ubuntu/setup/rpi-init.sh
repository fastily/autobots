#!/bin/bash

#: Install some helpful packages and apply sane settings for Ubuntu on Raspberry pi 2/3.
#: 
#: Tested on Ubuntu 18.04.2
#: Author: Fastily

cd "${0%/*}" &> /dev/null

## Install packages
sudo apt update && sudo apt -y install fail2ban openjdk-11-jre-headless

## Install and configure OpenSSH
bash ../installers/OpenSSH.sh
curl 'https://gist.githubusercontent.com/fastily/4695d2bca65d91958f602bfb8d497def/raw/fd1b441b9f36c620ac0a3f1d9db5cb87b5cd4d3d/pi.pub' >> ~/.ssh/authorized_keys
sudo service ssh restart

## Configure ~/bin and aliases
bash ../util/confEnv.sh

printf "Done!\n"