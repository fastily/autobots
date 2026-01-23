#!/bin/bash

#: Installs Homebrew on ubuntu
#: 
#: Intended for Ubuntu 22.04
#: Author: Fastily

set -e

sudo apt update
sudo apt install -y build-essential procps curl file git
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
printf '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "${HOME}/.profile"