#!/bin/bash

#: Generic, set up my working environment.
#:
#: PRECONDITION:
#:		1) Xcode or Xcode tools are installed
#:
#: Tested on macOS 10.12.1
#: Author: Fastily

## Make sure xcode is installed
which xcrun &> /dev/null
if [ $? -ne 0 ]; then
	printf "[ERROR]: Xcode is not installed.  Exiting.\n"
	exit 1
fi

## Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Make sure the install worked
which brew &> /dev/null
if [ $? -ne 0 ]; then
	printf "[ERROR]: Homebrew is not installed.  Something went wrong!\n"
	exit 1
fi

brew doctor


## Create .bash_profile
cd ~
BPROFILE=".bash_profile"
touch "$BPROFILE"

## Recusrively deletes .DS_STORE from the current directory
printf "alias ddss=\"find . -name '*.DS_Store' -type f -delete\"\n" >> "$BPROFILE"

## Create bin folder in HOME and add it to PATH
mkdir -p bin
printf "PATH=${PATH}:${HOME}/bin\n" >> "$BPROFILE"

## Copy custom scripts to bin
cd "${0%/*}" &> /dev/null
cp scripts/* ~/bin

## Setup .ssh
printf "Creating .ssh folder in home directory\n"
mkdir -p ~/.ssh

## Initialize git name and email
printf "Setting git global vars\n"
git config --global user.name "fastily"
git config --global user.email "fastily@users.noreply.github.com"

## Install dependencies for my custom scripts
brew update
brew install eye-d3
brew install youtube-dl

## Misc Settings
defaults write com.apple.TextEdit RichText -int 0


printf "Done!\n"