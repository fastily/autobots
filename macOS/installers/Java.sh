#!/usr/bin/env bash

#: Installs my working environment for Java development.
#:
#: Author: Fastily

brew install --cask adoptopenjdk eclipse-java
brew install gnupg gradle

mkdir -p ~/.gradle
ln -s ~/Documents/keys/gradle.properties .gradle/gradle.properties
ln -s ~/Documents/keys/gnupg .gnupg