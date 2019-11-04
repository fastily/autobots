#!/bin/bash

#: Set my preferred bash aliases and create user's bin folder
#: 
#: Tested on Ubuntu 18.04
#: Author: Fastily

## create user bin and aliases
mkdir -p ~/bin

printf '\nalias uuu="sudo apt update && sudo apt upgrade -y"' >> ~/.bash_aliases
printf '\nalias aaa="sudo apt autoclean && sudo apt autoremove -y"' >> ~/.bash_aliases