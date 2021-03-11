#!/bin/bash

#: Installs prerequisites to add pinyin as an input source in ubuntu
#: 
#: Tested on Ubuntu 18.04
#: Author: Fastily

set -e

sudo apt update
sudo apt -y install ibus-pinyin
sleep 3
ibus restart

printf "Done!\nNow, go to Settings -> Region & Language -> Input Sources (+) and add Pinyin\n"