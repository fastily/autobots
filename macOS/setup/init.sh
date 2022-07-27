#!/usr/bin/env bash

#: Installs my working environment and preferred applications
#:
#: PRECONDITIONS: 
#:		1) Homebrew is installed
#:
#: Author: Fastily

## custom scripts and settings
cd "${0%/*}" &> /dev/null

set -e

bash ../scripts/deploy.sh
bash settings.sh

# brew not automatically on PATH for Apple Silicon
if [[ $(arch) == "arm64" ]]; then
	eval $("/opt/homebrew/bin/brew" shellenv)
fi

## Install Apps
brew install bash-completion@2 exiftool ffmpeg gnu-sed gnu-tar imagemagick iperf3 nmap p7zip python rdfind rg wget yt-dlp # mas node
brew install --cask dbeaver-community firefox knockknock postman steam sublime-text visual-studio-code vlc # blackhole-2ch private-internet-access taskexplorer

## Patch Antiques
brew install bash less openssh rsync

## Global python packages
pip3 install virtualenv

## VSCode settings and extensions
code --install-extension ms-python.python --install-extension ms-python.vscode-pylance --install-extension njpwerner.autodocstring --install-extension octref.vetur --install-extension ritwickdey.liveserver --install-extension github.copilot # --install-extension zignd.html-css-class-completion

VSCODE_DIR=~/'Library/Application Support/Code/User'
mkdir -p "$VSCODE_DIR"
cat > "${VSCODE_DIR}/settings.json" <<EOF
{
	"python.linting.pylintArgs": ["-d", "C0103,C0301,W0703"],
	"python.formatting.autopep8Args": ["--max-line-length", "300"],
	"python.languageServer": "Pylance",
	"terminal.integrated.defaultProfile.osx": "bash",
	"html.format.wrapLineLength": 0
}
EOF

#"python.linting.pylintArgs": ["--load-plugins", "pylint_django"]

## Create folders and symlinks
cd ~
mkdir -p Documents/{git,keys,scripts}
ln -s Documents/keys/ssh .ssh
ln -s Documents/keys/pypirc.txt .pypirc

echo "Done!"