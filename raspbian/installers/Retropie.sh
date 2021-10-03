#!/bin/bash

#: Installs Retropie
#: 
#: Author: Fastily

cd
git clone --depth 1 "https://github.com/RetroPie/RetroPie-Setup.git"

cd "RetroPie-Setup"
sudo ./retropie_setup.sh