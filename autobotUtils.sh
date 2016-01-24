#!/bin/bash

#: Shared library functions for unix-based systems in autobots.
#: 
#: Tested on Ubuntu Server 15.10 and OS X 10.11
#: Author: Fastily


##
# Checks if the script was run as root.  Prints an error message and exits if the script was not run as root.
##
confirmRunAsRoot()
{
	if [ "$EUID" -ne 0 ]; then
		printf "[ERROR]: Script must be run as root (sudo)\n"
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