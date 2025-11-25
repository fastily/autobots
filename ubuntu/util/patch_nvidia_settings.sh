#!/usr/bin/env bash

#: Update grub settings to work with buggy nvidia driver
#: 
#: Tested on Ubuntu 20.04
#: Author: Fastily

set -e

sudo tee "/etc/default/grub.d/99_my_custom.cfg" > /dev/null << EOF
GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"
EOF

sudo update-grub

echo "Done, please reboot.  Also be sure to enable boot with Legacy BIOS, and disable optimizations in BIOS (fast boot, quiet boot)"