#!/bin/bash

#: Generic, set up my working environment.
#:
#: PRECONDITION:
#:		1) Xcode or Xcode tools are installed
#:
#: Author: Fastily

## Setup Custom Scripts
cd "${0%/*}" &> /dev/null
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
git config --global user.email 'fastily@users.noreply.github.com'

## Install script dependencies
brew tap caskroom/versions
brew cask install java8

brew install exiftool
brew install eye-d3
brew install ffmpeg --with-theora --with-libvorbis --with-libvpx --with-opus --with-fdk-aac --with-x265 --with-tools 
brew install gradle
#brew install imagemagick --with-librsvg --with-webp
brew install mysql
brew install nmap
brew install nodejs
brew install python
# brew install ruby
brew install sox --with-libao --with-opusfile --with-opencore-amr
brew install unrar
brew install wget
brew install youtube-dl

## Install Apps
# brew cask install atom
brew cask install firefox
brew cask install iina
brew cask install mysqlworkbench
brew cask install private-internet-access
brew cask install postman
brew cask install sts
brew cask install sublime-text
brew cask install rekordbox
brew cask install visual-studio-code
# brew cask install vlc

## Patch Antiques
brew install bash
brew install less
brew install openssh
brew install rsync
#brew install vim --with-override-system-vi

## Install global npm packages
# npm install -g bootlint

npm install -g eslint

## Install Atom Packages
# apm install atom-bootstrap3
# apm install atom-ternjs
# apm install autocomplete-modules
# apm install docblockr
# apm install language-babel
# apm install linter
# apm install linter-bootlint
# apm install linter-ui-default

## Install Gems
# gem install jekyll bundler

## Misc Settings
defaults write com.apple.TextEdit RichText -int 0 # Start TextEdit in plain text mode

defaults write com.apple.finder FXDefaultSearchScope -string SCcf # Finder searches in the current folder
defaults write com.apple.finder ShowRecentTags -bool false # hide recent tags

defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # disable autocorrect smart-quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false  # disable autocorrect smart-dashes

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true  # don't create .DS_STORE in SMB shares

# defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2HyperlinkAuditingEnabled -bool false # Disable trackers
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false  # disable auto-opening of downloads
defaults write com.apple.Safari CanPromptForPushNotifications -bool false # prevent websites from asking for push notifications
defaults write com.apple.Safari DownloadsClearingPolicy -bool false # don't remove downloads 
defaults write com.apple.Safari PreloadTopHit -bool false # don't preload top hit in background
defaults write com.apple.Safari PrintHeadersAndFooters -bool false # don't print webpage headers and footers
defaults write com.apple.Safari NewTabBehavior -int 1 # new tabs open in empty page
defaults write com.apple.Safari NewWindowBehavior -int 0 # new windows open to homepage
defaults write com.apple.Safari IncludeDevelopMenu -bool true # show develop menu
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false # match on contains instead of startswith
defaults write com.apple.Safari ShowOverlayStatusBar -bool true # always show status bar in bottom left corner

defaults -currentHost write com.apple.screensaver idleTime -int 0 # disable screensaver

defaults write com.apple.Terminal SecureKeyboardEntry -bool true # enable terminal secure keyboard entry
defaults write com.apple.Terminal "Default Window Settings" -string Pro # set default terminal window to Pro
defaults write com.apple.Terminal "Startup Window Settings" -string Pro # set startup window to Pro
defaults write com.apple.Terminal NewTabWorkingDirectoryBehavior -int 1 # New tabs should open with default working dir

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true # prevent Photos from opening when iPhone is connected

defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad USBMouseStopsTrackpad -bool true # disable trackpad in clamshell mode
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # tap to click

## Setup .ssh
printf "Creating .ssh folder in home directory\n"
mkdir -p ~/.ssh

printf "Done!\n"