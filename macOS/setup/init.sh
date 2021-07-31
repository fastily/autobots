#!/usr/bin/env bash

#: Installs my working environment and preferred applications
#:
#: Author: Fastily


##
# Checks if homebrew is installed on the user's PATH
##
is_brew_installed() {
	command -v brew &> /dev/null
}


## Install Homebrew if not installed
if ! is_brew_installed; then
	sudo -k && sudo -v
	echo | /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# brew bin/sbin not automatically on path for Apple Silicon
	if [ $(uname -m) == "arm64" ]; then
		export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"
	fi

	# sanity check
	if ! is_brew_installed; then
		echo "[ERROR]: Homebrew doesn't seem to be installed or isn't working right.  Abort."
		exit 1
	fi
fi

brew doctor
brew update

## Deploy custom scripts
cd "${0%/*}" &> /dev/null
bash ../scripts/deploy.sh
bash settings.sh

## Initialize git name and email
git config --global user.name "fastily"
git config --global user.email 'fastily@users.noreply.github.com'

## Install script dependencies
# brew tap AdoptOpenJDK/openjdk
# brew install --cask adoptopenjdk11
# brew cask install java

brew install bash-completion@2 exiftool ffmpeg gnupg imagemagick iperf3 nmap node p7zip python wget youtube-dl
#brew install gradle eye-d3

## Install Apps
brew install --cask chromium dbeaver-community docker firefox knockknock postman private-internet-access steam sublime-text taskexplorer visual-studio-code
# brew cask install eclipse-java elgato-game-capture-hd lulu rekordbox postgres zoom

## Patch Antiques
brew install bash less openssh rsync

## Homebrew Other
# brew install heroku/brew/heroku
# brew install sass/sass/sass

## Install python packages
pip3 install build twine virtualenv
# pip3 install autopep8 Django pylint pylint-django

## Install VSCode settings and extensions
code --install-extension ms-azuretools.vscode-docker --install-extension ms-python.python --install-extension ms-python.vscode-pylance \
	--install-extension njpwerner.autodocstring --install-extension octref.vetur --install-extension ritwickdey.liveserver --install-extension zignd.html-css-class-completion


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

## bash-completions for docker
# DOCKERETC="/Applications/Docker.app/Contents/Resources/etc"
# ln -s "${DOCKERETC}/docker.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker"
# ln -s "${DOCKERETC}/docker-machine.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker-machine"
# ln -s "${DOCKERETC}/docker-compose.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker-compose"

## Create .ssh and scripts folders
mkdir -p ~/Documents/git ~/Documents/scripts # ~/.gradle

## Create symlinks
cd "$HOME"
# ln -s ~/Documents/keys/gradle.properties .gradle/gradle.properties
ln -s ~/Documents/keys/gnupg .gnupg
ln -s ~/Documents/keys/ssh .ssh

echo "Done!"