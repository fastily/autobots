#!/usr/bin/env bash

#: Installs my working environment for development with Docker.
#:
#: Author: Fastily

brew install --cask docker visual-studio-code

## Vscode extension
code --install-extension ms-azuretools.vscode-docker

## bash-completions for docker
# DOCKERETC="/Applications/Docker.app/Contents/Resources/etc"
# ln -s "${DOCKERETC}/docker.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker"
# ln -s "${DOCKERETC}/docker-machine.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker-machine"
# ln -s "${DOCKERETC}/docker-compose.bash-completion" "$(brew --prefix)/etc/bash_completion.d/docker-compose"
