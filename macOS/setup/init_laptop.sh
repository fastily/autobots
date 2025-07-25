#!/usr/bin/env bash

#: Installs my working environment and preferred applications for my laptop
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
macbook_settings

brew install --cask mullvad-vpn protonvpn tailscale-app

echo "All set!  Please reboot for changes to take effect"