#!/usr/bin/env bash

#: Installs my working environment and preferred applications
#:
#: PRECONDITIONS: 
#:		1) Homebrew is installed
#:
#: Author: Fastily

cd "${0%/*}" &> /dev/null

set -e

bash base.sh

# brew not automatically on PATH for Apple Silicon
if [[ $(arch) == "arm64" ]] && ! command -v brew; then
	eval $("/opt/homebrew/bin/brew" shellenv)
fi

## Install Apps
brew install exiftool ffmpeg imagemagick yt-dlp # node p7zip
brew install --cask dbeaver-community google-chrome knockknock postman visual-studio-code vlc # blackhole-2ch

if [[ "$(sysctl hw.model)" == *"Macmini"* ]]; then
	brew install --cask steam
elif [[ "$(sysctl hw.model)" == *"MacBook"* ]]; then
	brew install --cask mullvadvpn
fi

## VSCode settings and extensions
code --install-extension ms-python.autopep8 --install-extension ms-python.python --install-extension ms-python.vscode-pylance --install-extension ms-vscode.live-server --install-extension njpwerner.autodocstring --install-extension Vue.volar  # --install-extension zignd.html-css-class-completion

VSCODE_DIR=~/'Library/Application Support/Code/User'
mkdir -p "$VSCODE_DIR"
cat > "${VSCODE_DIR}/settings.json" <<EOF
{
	"python.linting.pylintArgs": ["-d", "C0103,C0301,W0703"],
	"python.formatting.autopep8Args": ["--max-line-length", "300"],
	"terminal.integrated.defaultProfile.osx": "bash",
	"html.format.wrapLineLength": 0,
	"security.workspace.trust.enabled": false
	"[python]": {
		"editor.defaultFormatter": "ms-python.autopep8",
	},
	"autopep8.args": ["--max-line-length", "300"]
}
EOF
#"python.linting.pylintArgs": ["--load-plugins", "pylint_django"]

## Configure Pixelmator
defaults write com.pixelmatorteam.pixelmator.x fullSizeQuickLookPreview -bool true

## turn on firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

## Disable sleep and set display sleep to 30 mins while plugged in
sudo pmset -c sleep 0
sudo pmset -c displaysleep 30

## Create symlinks
cd ~
ln -s Documents/keys/pypirc.txt .pypirc
ln -s Documents/keys/px.txt .px.txt
ln -s Documents/keys/scu.px.txt .scu.px.txt

## Macbook specific settings
if [[ "$(sysctl hw.model)" == *"MacBook"* ]]; then
	## disable trackpad in clamshell mode
	# defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad USBMouseStopsTrackpad -int 1
	defaults write com.apple.AppleMultitouchTrackpad USBMouseStopsTrackpad -int 1

	## Tap to click
	defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
	defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1

	defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
fi


echo "Done, please reboot for changes to take effect"