#!/usr/bin/env bash

#: Configures/Installs my working environment and preferred applications for macOS servers
#:
#: PRECONDITIONS: 
#:		1) Homebrew is installed
#:
#: Author: Fastily

cd "${0%/*}" &> /dev/null

set -e

bash base.sh

# brew not automatically on PATH for Apple Silicon
if [[ $(arch) == "arm64" ]] && ! command -v brew; then
    eval $("/opt/homebrew/bin/brew" shellenv)
fi

# Disable sleep
sudo systemsetup -setcomputersleep "Off" &> /dev/null
sudo systemsetup -setdisplaysleep "Off" &> /dev/null

## Configure ssh server
SSHD_CONFIG="/etc/ssh/sshd_config"
sudo gsed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$SSHD_CONFIG"
sudo gsed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$SSHD_CONFIG"
sudo gsed -i -E 's/^\#?ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/' "$SSHD_CONFIG"

touch ~/.ssh/authorized_keys

## Set default shell to homebrew bash
[[ "$(arch)" == "arm64" ]] && my_bash="/opt/homebrew/bin/bash" || my_bash="/usr/local/bin/bash"
echo "$my_bash" | sudo tee -a /etc/shells &> /dev/null
sudo chsh -s "$my_bash" $(whoami)


echo "Done, please reboot for changes to take effect"