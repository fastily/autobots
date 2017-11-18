#!/bin/bash

#: Generic, set up my working environment.
#:
#: PRECONDITION:
#:		1) Xcode or Xcode tools are installed
#:
#: Tested on macOS 10.12.6
#: Author: Fastily

SCPTDIR="${0%/*}"

## Make sure xcode is installed
which xcrun &> /dev/null
if [ $? -ne 0 ]; then
	printf "[ERROR]: Xcode is not installed.  Exiting.\n"
	exit 1
fi

## Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

## Make sure the install worked
which brew &> /dev/null
if [ $? -ne 0 ]; then
	printf "[ERROR]: Homebrew is not installed.  Something went wrong!\n"
	exit 1
fi

brew doctor
brew update

cd "$SCPTDIR" &> /dev/null

## Copy .bash_profile and bin scripts
cp -fv bash_profile.txt ~/.bash_profile

cp -rv scripts ~/bin
chflags hidden ~/bin

## Setup .ssh
printf "Creating .ssh folder in home directory\n"
mkdir -p ~/.ssh

## Initialize git name and email
printf "Setting git global vars\n"
git config --global user.name "fastily"
git config --global user.email "fastily@users.noreply.github.com"


## Install dependencies for my custom scripts
brew cask install java8

brew install exiftool
brew install eye-d3
brew install ffmpeg --with-theora --with-libvorbis --with-libvpx --with-opus --with-fdk-aac --with-x265 --with-tools 
brew install gradle
brew install nodejs
brew install ruby
brew install sox --with-flac --with-lame --with-libao --with-libvorbis --with-opusfile --with-opencore-amr
brew install wget
brew install youtube-dl

brew cask install atom
brew cask install eclipse-java
#brew cask install firefox
#brew cask install private-internet-access
brew cask install postman
brew cask install sts
brew cask install sublime-text
brew cask install rekordbox
brew cask install vlc

## Patch Antiques
brew tap homebrew/dupes

brew install bash
brew install less
brew install openssh
brew install rsync
brew install vim --with-override-system-vi

## Misc Settings
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # Have Finder search current folder by default

## Trackers suck
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2HyperlinkAuditingEnabled -bool false

printf "Done!\n"