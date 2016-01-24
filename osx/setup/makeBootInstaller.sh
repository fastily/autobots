#!/bin/bash

#: Creates a bootable OS X installer 
#: 
#: PRECONDITIONS: 
#:		1) You have an empty USB thumb drive to create the bootable installer on
#: 		2) Install OS X El Capitan.app has been dwonloaded from the app store
#: ARGUMENTS:
#: 		$1 - The full path to the target USB Thumb Drive (e.g. '/Volumes/MyDrive')
#: 
#: Tested on OS X 10.11.3
#: Author: Fastily

## make sure we are root
source ../../autobotUtils.sh
confirmRunAsRoot

## Ensure that the the target drive volume exists
if [ -z "$1" ]; then
	printf "[ ERROR ]: You must specify the drive path to write to in the first argument\n"
fi

confirmDirExists "$1"

## Make sure that the installer has been downloaded
app="/Applications/Install OS X El Capitan.app"
confirmDirExists "$app"

## Run the script
printf "Generating bootable OS X drive at '%s'\n" "$1"
"${app}/Contents/Resources/createinstallmedia" --volume "$1" --applicationpath "$app"

printf "Done!\n"