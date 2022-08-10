#!/usr/bin/env bash

#: Configures/Installs my *basic* working environment and preferred applications
#:
#: PRECONDITIONS: 
#:		1) Homebrew is installed
#:
#: Author: Fastily

if [ ! -r "/Library/Preferences/com.apple.TimeMachine.plist" ]; then
    echo "[ERROR]: Terminal does not have Full Disk Access, please enable before retrying"
    exit 1
fi

## custom scripts and settings
cd "${0%/*}" &> /dev/null

set -e

bash ../scripts/deploy.sh

# brew not automatically on PATH for Apple Silicon
if [[ $(arch) == "arm64" ]] && ! command -v brew; then
    eval $("/opt/homebrew/bin/brew" shellenv)
fi

## Install Apps
brew install bash-completion@2 gnu-sed gnu-tar iperf3 nmap python rdfind rg wget
brew install --cask firefox knockknock sublime-text

## Patch Antiques
brew install bash less openssh rsync

## Global python packages
pip3 install virtualenv

## Create folders and symlinks
cd ~
mkdir -p Documents/{git,keys/ssh,scripts}
ln -s Documents/keys/ssh .ssh

## OS Settings
defaults write com.apple.TextEdit RichText -int 0 # Start TextEdit in plain text mode

defaults write com.apple.finder FXDefaultSearchScope -string SCcf # Finder searches in the current folder
defaults write com.apple.finder ShowRecentTags -bool false # hide recent tags

defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # disable autocorrect smart-quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false  # disable autocorrect smart-dashes

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true  # don't create .DS_STORE in SMB shares

# sudo systemsetup -setcomputersleep "Never"  # Disable sleep
defaults -currentHost write com.apple.screensaver idleTime -int 0 # disable screensaver

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

defaults write com.apple.dock "show-recents" -int 0 # hide recent applications from dock (applied after reboot or killall dock)

defaults write com.apple.Terminal SecureKeyboardEntry -bool true # enable terminal secure keyboard entry
defaults write com.apple.Terminal "Default Window Settings" -string Pro # set default terminal window to Pro
defaults write com.apple.Terminal "Startup Window Settings" -string Pro # set startup window to Pro
defaults write com.apple.Terminal NewTabWorkingDirectoryBehavior -int 1 # New tabs should open with default working dir

[[ "$(arch)" == "arm64" ]] && my_bash="/opt/homebrew/bin/bash" || my_bash="/usr/local/bin/bash"
defaults write com.apple.Terminal Shell -string "$my_bash" # set shell to locally patched bash

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true # prevent Photos from opening when iPhone is connected

sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on # turn on firewall

## May be broken
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad USBMouseStopsTrackpad -bool true # disable trackpad in clamshell mode
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # tap to click

## patch misconfigured default nfs config
printf "\nnfs.client.mount.options = vers=4\n" | sudo tee -a "/etc/nfs.conf" > /dev/null