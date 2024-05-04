#!/usr/bin/env bash

#: Shared functions for macOS intializer scripts.
#:
#: PRECONDITIONS: 
#:		1) Homebrew is installed
#:
#: Author: Fastily

##
# Checks if the script has the necessary permissions to run
##
sanity_check() {
    if [ ! -r "/Library/Preferences/com.apple.TimeMachine.plist" ]; then
        echo "[ERROR]: Terminal does not have Full Disk Access, please enable before retrying"
        exit 1
    fi
}

##
# Applies general/shared settings and installs shared apps
##
general_settings() {
    # brew not automatically on PATH for Apple Silicon
    if [[ $(arch) == "arm64" ]] && ! command -v brew; then
        eval $("/opt/homebrew/bin/brew" shellenv)
    fi

    # copy scripts and bash_profile
    cd "${0%/*}" &> /dev/null || true
    bash ../scripts/deploy.sh

    ## Install Apps
    brew install bash-completion@2 gnu-sed gnu-tar iperf3 nmap python rdfind rg wget virtualenv
    brew install --cask dbeaver-community google-chrome knockknock postman sublime-text visual-studio-code

    ## Patch Antiques
    brew install less openssh rsync

    ## VSCode settings and extensions
    code --install-extension ms-python.autopep8 --install-extension ms-python.python --install-extension ms-python.vscode-pylance --install-extension ms-vscode.live-server --install-extension njpwerner.autodocstring --install-extension Vue.volar  # --install-extension zignd.html-css-class-completion

    local VSCODE_DIR=~/'Library/Application Support/Code/User'
    mkdir -p "$VSCODE_DIR"
    cat > "${VSCODE_DIR}/settings.json" <<EOF
{
    "python.linting.pylintArgs": ["-d", "C0103,C0301,W0703"],
    "python.formatting.autopep8Args": ["--max-line-length", "300"],
    "terminal.integrated.defaultProfile.osx": "bash",
    "html.format.wrapLineLength": 0,
    "security.workspace.trust.enabled": false,
    "[python]": {
        "editor.defaultFormatter": "ms-python.autopep8",
    },
    "autopep8.args": ["--max-line-length", "300"]
}
EOF
    #"python.linting.pylintArgs": ["--load-plugins", "pylint_django"]

    ## Create folders and symlinks
    pushd ~
    mkdir -p Documents/{git,keys/ssh,scripts}
    ln -s Documents/keys/ssh .ssh
    popd

    ## OS Settings
    defaults write -globalDomain CGDisableCursorLocationMagnification -bool true # disable shake mouse pointer to locate

    defaults write com.apple.TextEdit RichText -int 0 # Start TextEdit in plain text mode

    defaults write com.apple.finder NewWindowTarget -string PfHm # New Finder windows open with home directory
    defaults write com.apple.finder FXDefaultSearchScope -string SCcf # Finder searches in the current folder
    defaults write com.apple.finder ShowRecentTags -bool false # hide recent tags

    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false # disable autocorrect smart-quotes
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false  # disable autocorrect smart-dashes

    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true  # don't create .DS_STORE in SMB shares

    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true # prevent Photos from opening when iPhone is connected

    defaults -currentHost write com.apple.screensaver idleTime -int 0 # disable screensaver

    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false  # disable auto-opening of downloads
    defaults write com.apple.Safari CanPromptForPushNotifications -bool false # prevent websites from asking for push notifications
    defaults write com.apple.Safari DownloadsClearingPolicy -bool false # don't remove downloads
    defaults write com.apple.Safari PreloadTopHit -bool false # don't preload top hit in background
    defaults write com.apple.Safari PrintHeadersAndFooters -bool false # don't print webpage headers and footers
    defaults write com.apple.Safari NewTabBehavior -int 1 # new tabs open in empty page
    defaults write com.apple.Safari NewWindowBehavior -int 0 # new windows open to homepage
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false # match on contains instead of startswith
    defaults write com.apple.Safari ShowOverlayStatusBar -bool true # always show status bar in bottom left corner
    defaults write com.apple.Safari HomePage -string "https://google.com/" # Set homepage
    defaults write com.apple.Safari HistoryAgeInDaysLimit -int 365000 # don't automatically clear history
    defaults write com.apple.Safari IncludeDevelopMenu -bool true # show develop menu pt 1
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true # show develop menu pt 2
    defaults write com.apple.Safari WebKitPreferences.developerExtrasEnabled -bool true # show develop menu pt 3

    defaults write com.apple.dock "show-recents" -int 0 # hide recent applications from dock (applied after reboot or killall dock)
    defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false # disable click wallpaper to show desktop

    defaults write com.apple.Terminal SecureKeyboardEntry -bool true # enable terminal secure keyboard entry
    defaults write com.apple.Terminal "Default Window Settings" -string Pro # set default terminal window to Pro
    defaults write com.apple.Terminal "Startup Window Settings" -string Pro # set startup window to Pro
    defaults write com.apple.Terminal NewTabWorkingDirectoryBehavior -int 1 # New tabs should open with default working dir
    plutil -replace "Window Settings.Pro.shellExitAction" -integer 1 ~/Library/Preferences/com.apple.Terminal.plist # close window if shell exited cleanly
    plutil -replace "Window Settings.Pro.rowCount" -integer 60 ~/Library/Preferences/com.apple.Terminal.plist # set window height 60
    plutil -replace "Window Settings.Pro.columnCount" -integer 180 ~/Library/Preferences/com.apple.Terminal.plist # set window width 180

    # suppress warning about bash running when closing window
    plutil -replace "Window Settings.Pro.noWarnProcesses" -array ~/Library/Preferences/com.apple.Terminal.plist
    local count=0
    for s in "screen" "tmux" "-bash"; do
        plutil -insert "Window Settings.Pro.noWarnProcesses" -dictionary -append ~/Library/Preferences/com.apple.Terminal.plist
        plutil -replace "Window Settings.Pro.noWarnProcesses.${count}.ProcessName" -string "$s" ~/Library/Preferences/com.apple.Terminal.plist
        ((count++))
    done

    [[ "$(arch)" == "arm64" ]] && local my_bash="/opt/homebrew/bin/bash" || local my_bash="/usr/local/bin/bash"
    defaults write com.apple.Terminal Shell -string "$my_bash" # set shell to locally patched bash

    ## Set default shell to homebrew bash
    echo "$my_bash" | sudo tee -a "/etc/shells" &> /dev/null
    sudo chsh -s "$my_bash" $(whoami)

    ## patch misconfigured default nfs config
    printf "\nnfs.client.mount.options = vers=4\n" | sudo tee -a "/etc/nfs.conf" &> /dev/null

    ## turn on firewall
    sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

    ## Disable sleep and set display sleep to 30 mins while plugged in
    sudo pmset -c sleep 0
    sudo pmset -c displaysleep 30
}

##
# Installs apps/programs for my personal devices
##
setup_personal() {
    brew install cloudflared exiftool ffmpeg imagemagick yt-dlp # node p7zip
    brew install --cask vlc # blackhole-2ch

    ## Configure Pixelmator
    # defaults write com.pixelmatorteam.pixelmator.x fullSizeQuickLookPreview -bool true

    ## Create symlinks
    cd ~
    ln -s Documents/keys/bash_keys.sh .bash_keys
}

##
# Applies Macbook-specific configuration
##
macbook_settings() {
    ## disable trackpad in clamshell mode
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad USBMouseStopsTrackpad -int 1
    defaults write com.apple.AppleMultitouchTrackpad USBMouseStopsTrackpad -int 1

    ## Tap to click
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
    defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1

    defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
}