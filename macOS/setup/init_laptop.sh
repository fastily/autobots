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
setup_dev_tools
macbook_settings

brew install --cask mullvadvpn