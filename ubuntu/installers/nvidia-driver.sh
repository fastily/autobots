#!/usr/bin/env bash

#: Installs nvidia drivers from upstream ppa.  Check [https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa] for versions
#: 
#: ARGUMENTS:
#:      $1 - The version of the nvidia driver to install (e.g. "550")
#:
#: Tested on Ubuntu 22.04
#: Author: Fastily

set -e

if (( $# < 1 )); then
  echo "Usage: ${0##*/} <VERSION_TO_INSTALL>"
  exit 1
fi

sudo add-apt-repository -y "ppa:graphics-drivers/ppa"
sudo apt update
sudo apt install -y "nvidia-driver-${NVIDIA_VERSION}"

echo "All set, reboot for changes to take effect"