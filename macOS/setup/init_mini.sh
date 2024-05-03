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
setup_dev_tools

brew install --cask steam