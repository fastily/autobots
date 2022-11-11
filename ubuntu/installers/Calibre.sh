#!/bin/bash

#: Installs latest version of Calibre
#: 
#: Tested on Ubuntu Desktop 18.04
#: Author: Fastily

sudo -v && wget -nv -O- "https://download.calibre-ebook.com/linux-installer.sh" | sudo sh /dev/stdin