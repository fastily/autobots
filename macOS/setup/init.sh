#!/bin/bash

#: Installs my working environment and preferred applications
#:
#: Author: Fastily

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

brew install bash-completion exiftool ffmpeg gradle imagemagick nmap nodejs python unrar wget youtube-dl
#brew install eye-d3

## Install Apps
brew cask install chromium dbeaver-community docker eclipse-java firefox iina knockknock lulu postgres postman private-internet-access steam sublime-text taskexplorer visual-studio-code
# brew cask install elgato-game-capture-hd rekordbox springtoolsuite 

## Patch Antiques
brew install bash less openssh rsync

## Homebrew Other
brew install sass/sass/sass

## Install python packages
pip3 install autopep8 django Flask pillow psycopg2-binary pylint pylint-django requests twine virtualenv watchdog websockets whitenoise

## Install VSCode settings and extensions
code --install-extension ms-azuretools.vscode-docker --install-extension ms-python.python --install-extension njpwerner.autodocstring --install-extension octref.vetur --install-extension ritwickdey.liveserver --install-extension zignd.html-css-class-completion

mkdir -p ~/'Library/Application Support/Code/User/'
printf '{
	"python.linting.pylintArgs": ["--load-plugins", "pylint_django"],
	"python.pythonPath": "/usr/local/bin/python3",
	"python.formatting.autopep8Args": ["--max-line-length", "180"],
	"html.format.wrapLineLength": 0}' > ~/'Library/Application Support/Code/User/settings.json'

## bash-completions for docker
DOCKERETC="/Applications/Docker.app/Contents/Resources/etc"
ln -s "${DOCKERETC}/docker.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker"
ln -s "${DOCKERETC}/docker-machine.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker-machine"
ln -s "${DOCKERETC}/docker-compose.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker-compose"

## Create .ssh and scripts folders
mkdir -p ~/.ssh ~/Documents/git ~/Documents/scripts

printf "Done!\n"