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

## Configure ssh server
SSHD_CONFIG="/etc/ssh/sshd_config"
sudo gsed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$SSHD_CONFIG"
sudo gsed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$SSHD_CONFIG"
sudo gsed -i -E 's/^\#?ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/' "$SSHD_CONFIG"

touch ~/.ssh/authorized_keys


echo "Done!"