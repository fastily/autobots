#!/usr/bin/env bash

#: Harden ssh server on macOS
#: 
#: PRECONDITIONS: 
#:		1) Homebrew gsed is installed
#:
#: Author: Fastily

sudo gsed -i -E 's/^\#?PermitRootLogin .*/PermitRootLogin no/' "$SSH_CONFIG"
sudo gsed -i -E 's/^\#?PasswordAuthentication .*/PasswordAuthentication no/' "$SSH_CONFIG"
sudo gsed -i -E 's/^\#?ChallengeResponseAuthentication .*/ChallengeResponseAuthentication no/' "$SSH_CONFIG"