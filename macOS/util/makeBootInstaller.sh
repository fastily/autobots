#!/bin/bash

#: Creates a bootable macOS installer 
#: 
#: PRECONDITIONS: 
#:		1) You have an empty USB thumb drive to create the bootable installer on
#: 		2) Install macOS High Sierra.app has been downloaded from the app store
#: ARGUMENTS:
#: 		$1 - The full path to the target USB Thumb Drive (e.g. '/Volumes/MyDrive')
#: 
#: Tested on OS X 10.13.1
#: Author: Fastily

## make sure we are root
source ../../shared/autobotUtils.sh
confirmRunAsRoot

## Ensure that the the target drive volume exists
if [ -z "$1" ]; then
	printf "Usage: makeBootInstaller <PATH_TO_USB>\n"
	exit 1
fi

confirmDirExists "$1"

## Make sure that the installer has been downloaded
app="/Applications/Install macOS High Sierra.app"
confirmDirExists "$app"

## Run the script
printf "Creating bootable intsall at '%s'\n" "$1"
"${app}/Contents/Resources/createinstallmedia" --volume "$1" --applicationpath "$app"

printf "Done!\n"