#!/bin/bash

#: Installs python3 from source
#: 
#: Author: Fastily

PYVERSION="3.9.2"
PYFOLDER="Python-${PYVERSION}"
PYTAR="${PYFOLDER}.tgz"

set -e

sudo sed -i -E 's/#deb-src/deb-src/' '/etc/apt/sources.list'
sudo apt update
sudo apt build-dep -y python3

# extras
sudo apt install -y build-essential libffi-dev tk-dev libncurses5-dev \
    libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev \
    libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev libffi-dev

cd /tmp
wget "https://www.python.org/ftp/python/${PYVERSION}/${PYTAR}"
tar -xzf "$PYTAR"

cd "$PYFOLDER"

./configure --enable-optimizations
make
make test
sudo make altinstall