#!/usr/bin/env bash

#: Applies my preferred settings for Mac
#:
#: Author: Fastily

## OS Settings
defaults write com.apple.TextEdit RichText -int 0 # Start TextEdit in plain text mode

defaults write com.apple.finder FXDefaultSearchScope -string SCcf # Finder searches in the current folder
defaults write com.apple.finder ShowRecentTags -bool false # hide recent tags

defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # disable autocorrect smart-quotes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false  # disable autocorrect smart-dashes

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true  # don't create .DS_STORE in SMB shares

## May be broken due to way Mojave sets permissions - waiting on workaround
# defaults write com.apple.Safari AutoOpenSafeDownloads -bool false  # disable auto-opening of downloads
# defaults write com.apple.Safari CanPromptForPushNotifications -bool false # prevent websites from asking for push notifications
# defaults write com.apple.Safari DownloadsClearingPolicy -bool false # don't remove downloads 
# defaults write com.apple.Safari PreloadTopHit -bool false # don't preload top hit in background
# defaults write com.apple.Safari PrintHeadersAndFooters -bool false # don't print webpage headers and footers
# defaults write com.apple.Safari NewTabBehavior -int 1 # new tabs open in empty page
# defaults write com.apple.Safari NewWindowBehavior -int 0 # new windows open to homepage
# defaults write com.apple.Safari IncludeDevelopMenu -bool true # show develop menu
# defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false # match on contains instead of startswith
# defaults write com.apple.Safari ShowOverlayStatusBar -bool true # always show status bar in bottom left corner

defaults -currentHost write com.apple.screensaver idleTime -int 0 # disable screensaver

defaults write com.apple.Terminal SecureKeyboardEntry -bool true # enable terminal secure keyboard entry
defaults write com.apple.Terminal "Default Window Settings" -string Pro # set default terminal window to Pro
defaults write com.apple.Terminal "Startup Window Settings" -string Pro # set startup window to Pro
defaults write com.apple.Terminal NewTabWorkingDirectoryBehavior -int 1 # New tabs should open with default working dir

defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true # prevent Photos from opening when iPhone is connected

## May be broken
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad USBMouseStopsTrackpad -bool true # disable trackpad in clamshell mode
# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true # tap to click