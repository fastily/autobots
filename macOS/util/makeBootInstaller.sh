#!/usr/bin/env bash

#: Creates a bootable macOS installer 
#: 
#: PRECONDITIONS: 
#:		1) You have an empty USB thumb drive to create the bootable installer on
#: 		2) Install macOS Big Sur.app has been downloaded from the app store
#: ARGUMENTS:
#: 		$1 - The full path to the target USB Thumb Drive (e.g. '/Volumes/MyDrive')
#: 
#: Author: Fastily

APP="/Applications/Install macOS Big Sur.app/Contents/Resources/createinstallmedia"

if [ $# -lt 1 ]; then
	printf "Usage: makeBootInstaller <PATH_TO_USB>\n"
	exit
fi

if [ ! -d "$1" ] || [ ! -f "$APP" ]; then
	printf "ERROR: '%s' or '%s' does not exist!\n" "$1" "$APP"
	exit 1
fi

printf "Creating bootable installer out of '%s'\n" "$1"
sudo "$APP" --nointeraction --volume "$1" && sync