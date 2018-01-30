#!/bin/bash

#: Generic, set up my working environment.
#:
#: PRECONDITION:
#:		1) Xcode or Xcode tools are installed
#:
#: Author: Fastily

## Setup Custom Scripts
cd "${0%/*}" &> /dev/null && \
bash scripts/deploy.sh

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

## Initialize git name and email
printf "Setting git global vars\n"
git config --global user.name "fastily"
git config --global user.email "fastily@users.noreply.github.com"


## Install script dependencies
brew cask install java8

brew install exiftool
brew install eye-d3
brew install ffmpeg --with-theora --with-libvorbis --with-libvpx --with-opus --with-fdk-aac --with-x265 --with-tools 
brew install gradle
#brew install imagemagick --with-librsvg
brew install nmap
brew install nodejs
brew install ruby
brew install sox --with-flac --with-lame --with-libao --with-libvorbis --with-opusfile --with-opencore-amr
brew install unrar
brew install wget
brew install youtube-dl

## Install Apps
brew cask install atom
#brew cask install darktable
brew cask install eclipse-java
#brew cask install firefox
#brew cask install inkscape
brew cask install private-internet-access
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
#brew install vim --with-override-system-vi

## Install global npm packages
npm install -g bootlint

## Install Atom Packages
apm install atom-bootstrap3
apm install atom-ternjs
apm install autocomplete-modules
apm install docblockr
apm install language-babel
apm install linter
apm install linter-bootlint
apm install linter-ui-default

## Install Gems
gem install jekyll bundler

## Misc Settings
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf" # Have Finder search current folder by default

## Trackers suck
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2HyperlinkAuditingEnabled -bool false

## Setup .ssh
printf "Creating .ssh folder in home directory\n"
mkdir -p ~/.ssh

printf "Done!\n"