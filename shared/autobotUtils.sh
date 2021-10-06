#!/bin/bash

#: Shared library functions for unix-based systems in autobots.
#: 
#: Tested on Ubuntu Server 16.04 and OS X 10.13.1
#: Author: Fastily


##
# Checks if the script was run as root.  Prints an error message and exits if the script was not run as root.
##
confirmRunAsRoot()
{
	if [ "$EUID" -ne 0 ]; then
		printf "[ERROR]: Script must be run as root/sudo\n"
		exit 1
	fi
}

##
# Determines if a file exists.  Prints an error message and exits if the file was not found.
##
confirmFileExists()
{
	if [ ! -f "$1" ]; then
		printf "[ERROR]: '%s' does not exist, exiting\n" "$1"
		exit 1
	fi
}

##
# Determines if a directory exists.  Prints an error message and exits if the directory was not found.
##
confirmDirExists()
{
	if [ ! -d "$1" ]; then
		printf "[ERROR]: '%s' does not exist, exiting\n" "$1"
		exit 1
	fi
}

##
# Creates a directory and assigns the specified owner.
# PARAMETERS:
# 		$1 - path to directory to create
# 		$2 - user to assign as owner
##
mkdirWithOwner()
{
	mkdir -p "$1" && chown "$2" "$1"
}

##
# Tocuh a file and assign the specified owner.
# PARAMETERS:
# 		$1 - path to file to touch
# 		$2 - user to assign as owner
##
touchWithOwner()
{
	touch "$1" && chown "$2" "$1"
}