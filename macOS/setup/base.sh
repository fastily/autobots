#!/usr/bin/env bash

#: Configures/Installs my *basic* working environment and preferred applications
#:
#: PRECONDITIONS: 
#:		1) Homebrew is installed
#:
#: Author: Fastily

if [ ! -r "/Library/Preferences/com.apple.TimeMachine.plist" ]; then
    echo "[ERROR]: Terminal does not have Full Disk Access, please enable before retrying"
    exit 1
fi

## custom scripts and settings
cd "${0%/*}" &> /dev/null

set -e

bash ../scripts/deploy.sh
bash settings.sh

# brew not automatically on PATH for Apple Silicon
if [[ $(arch) == "arm64" ]]; then
	eval $("/opt/homebrew/bin/brew" shellenv)
fi

## Install Apps
brew install bash-completion@2 gnu-sed gnu-tar iperf3 nmap python rdfind rg wget
brew install --cask firefox knockknock sublime-text

## Patch Antiques
brew install bash less openssh rsync

## Global python packages
pip3 install virtualenv

## Create folders and symlinks
cd ~
mkdir -p Documents/{git,keys/ssh,scripts}
ln -s Documents/keys/ssh .ssh