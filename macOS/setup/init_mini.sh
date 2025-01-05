#!/usr/bin/env bash

#: Installs my working environment and preferred applications for my desktop
#:
#: PRECONDITIONS: 
#:		1) Homebrew is installed
#:
#: Author: Fastily

set -e
source "shared.sh"

sanity_check
general_settings
setup_personal

brew install --cask steam
softwareupdate --install-rosetta --agree-to-license

echo "All set!  Please reboot for changes to take effect"