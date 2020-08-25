#!/bin/bash

#: Installs my working environment and preferred applications
#:
#: Author: Fastily

## Install Homebrew if not installed
if ! command -v brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

	# sanity check
	if ! command -v brew; then
		printf "[ERROR]: Homebrew doesn't seem to be installed or isn't working right.  Abort."
		exit 1
	fi
fi

brew doctor
brew update

# stop here if --basic flag is set
if [[ $* == *--basic* ]]; then
	exit
fi

## Deploy custom scripts
cd "${0%/*}" &> /dev/null
bash ../scripts/deploy.sh
bash settings.sh

## Initialize git name and email
printf "Setting git global vars\n"
git config --global user.name "fastily"
git config --global user.email 'fastily@users.noreply.github.com'

## Install script dependencies
brew tap AdoptOpenJDK/openjdk
brew cask install adoptopenjdk11
# brew cask install java

brew install bash-completion exiftool ffmpeg gradle gnupg imagemagick nmap nodejs python unrar wget youtube-dl
#brew install eye-d3

## Install Apps
brew cask install chromium dbeaver-community docker eclipse-java firefox iina knockknock lulu postgres postman private-internet-access steam sublime-text taskexplorer visual-studio-code zoomus
# brew cask install elgato-game-capture-hd rekordbox springtoolsuite 

## Patch Antiques
brew install bash less openssh rsync

## Homebrew Other
brew install heroku/brew/heroku
brew install sass/sass/sass

## Install python packages
pip3 install autopep8 Django pylint pylint-django twine virtualenv

## Install VSCode settings and extensions
code --install-extension ms-azuretools.vscode-docker --install-extension ms-python.python --install-extension njpwerner.autodocstring --install-extension octref.vetur --install-extension ritwickdey.liveserver --install-extension zignd.html-css-class-completion

mkdir -p ~/'Library/Application Support/Code/User/'
printf '{
	"python.linting.pylintArgs": ["--load-plugins", "pylint_django", "-d", "C0103,C0301,W0703"],
	"python.pythonPath": "/usr/local/bin/python3",
	"python.formatting.autopep8Args": ["--max-line-length", "180"],
	"html.format.wrapLineLength": 0}' > ~/'Library/Application Support/Code/User/settings.json'

## bash-completions for docker
DOCKERETC="/Applications/Docker.app/Contents/Resources/etc"
ln -s "${DOCKERETC}/docker.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker"
ln -s "${DOCKERETC}/docker-machine.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker-machine"
ln -s "${DOCKERETC}/docker-compose.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker-compose"

## Create .ssh and scripts folders
mkdir -p ~/.gradle ~/Documents/git ~/Documents/scripts

## Create symlinks
cd "$HOME"
ln -s ~/Documents/keys/gradle.properties .gradle/gradle.properties
ln -s ~/Documents/keys/gnupg .gnupg
ln -s ~/Documents/keys/ssh .ssh

printf "Done!\n"