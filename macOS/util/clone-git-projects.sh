#!/usr/bin/env bash

#: Clones my git repositories for development.
#:
#: Author: Fastily

## Initialize git name and email
git config --global user.name "fastily"
git config --global user.email 'fastily@users.noreply.github.com'

## Create git dir
git_dir=~/"Documents/git"
mkdir -p "$git_dir"
cd "$git_dir"

## Setup general projects
repos=( "4chan-ripper" "backup-utils" "cheatsheet" "ddel" "dumb-file-drop" "fastilybot" "fastilybot-toolforge" "fcpx-presets" "ftools" "jinja2html" "mtc-cli" "notebook" "pwiki" "simple-commons-uploader" "snippets" )
for repo in "${repos[@]}"; do
	git clone "https://github.com/fastily/${repo}.git"
done