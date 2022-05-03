#!/usr/bin/env bash

#: Installs the Homebrew package manager.
#:
#: Author: Fastily

sudo -k && sudo -v
echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"