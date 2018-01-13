#!/bin/bash

#: Installs MakeMKV for Ubuntu.  Not 100% automatic, there will be prompts during the installation.
#: See also: [https://www.makemkv.com/forum2/viewtopic.php?f=3&t=224]
#: 
#: Tested on Ubuntu 16.04.3.
#: Author: Fastily

sudo apt install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev libqt4-dev

mkvVERSION="1.10.9"
mkvBIN="makemkv-bin-${mkvVERSION}"
mkvOSS="makemkv-oss-${mkvVERSION}"

cd /tmp
wget "https://www.makemkv.com/download/${mkvBIN}.tar.gz"
wget "https://www.makemkv.com/download/${mkvOSS}.tar.gz"

tar -xvzf "${mkvBIN}.tar.gz"
tar -xvzf "${mkvOSS}.tar.gz"

cd "$mkvOSS" && \
./configure && \
make && \
sudo make install

cd "../${mkvBIN}" && \
make && \
sudo make install

printf "Done!\n"