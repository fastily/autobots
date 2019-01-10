#!/bin/bash

#: Sets up my Mac.
#:
#: Author: Fastily

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

# stop here if --basic flag is set
if [[ $* == *--basic* ]]; then
	exit
fi

## Deploy custom scripts
cd "${0%/*}" &> /dev/null
bash scripts/deploy.sh
bash settings.sh

## Initialize git name and email
printf "Setting git global vars\n"
git config --global user.name "fastily"
git config --global user.email 'fastily@users.noreply.github.com'

## Install script dependencies
brew tap caskroom/versions
brew cask install java8

brew install exiftool
#brew install eye-d3
brew install ffmpeg --with-fdk-aac
brew install gradle
#brew install imagemagick --with-librsvg --with-webp
# brew install mysql
brew install nmap
brew install nodejs
brew install python
#brew install ruby
#brew install sox --with-libao --with-opusfile --with-opencore-amr
brew install unrar
brew install wget
brew install youtube-dl

## Install Apps
brew cask install docker
brew cask install firefox
brew cask install iina
brew cask install mysqlworkbench
brew cask install private-internet-access
brew cask install postgres
brew cask install postman
brew cask install springtoolsuite
brew cask install sublime-text
# brew cask install rekordbox
brew cask install visual-studio-code
#brew cask install vlc

## Patch Antiques
brew install bash
brew install less
brew install openssh
brew install rsync
#brew install vim --with-override-system-vi

## Install python packages
pip3 install psycopg2-binary
pip3 install django
pip3 install pillow
pip3 install pylint
pip3 install pylint-django
pip3 install requests
pip3 install twine
pip3 install virtualenv

## Install VSCode settings and extensions
code --install-extension ms-python.python

mkdir -p ~/'Library/Application Support/Code/User/'
printf '{"python.linting.pylintArgs": ["--load-plugins=pylint_django"], "python.pythonPath": "/usr/local/bin/python3"}' > ~/'Library/Application Support/Code/User/settings.json'

## Install global npm packages
# npm install -g bootlint
# npm install -g eslint

## Install Gems
# gem install jekyll bundler

## Create .ssh and scripts folders
mkdir -p ~/.ssh ~/Documents/scripts

printf "Done!\n"