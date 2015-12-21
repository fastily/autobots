#!/bin/bash

#: Sets up Homebrew package manager on OS X
#: 
#: PRECONDITIONS: 
#:		1) Xcode or Xcode tools are installed
#: 
#: Tested on OS X 10.11.2
#: Author: Fastily

## Is Xcode installed?
which xcrun &> /dev/null
if [ $? -ne 0 ]; then
	printf "[ERROR]: Xcode is not installed.  Exiting.\n"
	exit 1
fi

## Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Sanity check
which brew &> /dev/null
if [ $? -ne 0 ]; then
	printf "[ERROR]: Homebrew is not installed.  Something went wrong!\n"
	exit 1
fi

brew doctor