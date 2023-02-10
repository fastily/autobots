#!/bin/bash

#: Installs Homebrew on ubuntu
#: 
#: Intended for Ubuntu 22.04
#: Author: Fastily

sudo apt update && sudo apt install -y build-essential curl file git procps

bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
printf '\neval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"\n' >> "${HOME}/.profile"