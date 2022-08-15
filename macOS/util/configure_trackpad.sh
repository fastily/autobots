#!/usr/bin/env bash

#: Sets sane trackpad settings for Macbooks.
#:
#: Author: Fastily

if [ ! -r "/Library/Preferences/com.apple.TimeMachine.plist" ]; then
    echo "[ERROR]: Terminal does not have Full Disk Access, please enable before retrying"
    exit 1
fi

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad USBMouseStopsTrackpad -int 1 # disable trackpad in clamshell mode
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1 # tap to click