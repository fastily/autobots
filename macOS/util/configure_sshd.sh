#!/usr/bin/env bash

#: Harden ssh server on macOS
#: 
#: PRECONDITIONS: 
#:		1) Homebrew gnu-sed is installed
#:
#: Author: Fastily


SSHD_CONFIG="/etc/ssh/sshd_config"

sudo gsed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$SSHD_CONFIG"
sudo gsed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$SSHD_CONFIG"
sudo gsed -i -E 's/^\#?ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/' "$SSHD_CONFIG"