#!/bin/bash

#: Set my preferred bash aliases and create user's bin folder
#: 
#: Tested on Ubuntu 18.04
#: Author: Fastily

## create user bin and aliases
mkdir -p ~/bin

printf '\nalias uuaa="sudo apt update && sudo apt upgrade -y && sudo apt autoclean && sudo apt autoremove -y"' >> ~/.bash_aliases