#!/usr/bin/env bash

#: Clones my git repositories for development.
#:
#: PRECONDITION:
#:		1) I am logged into git
#:
#: Author: Fastily

GIT_DIR=~/"Documents/git"
GITHUB='https://github.com/fastily'

##
# Clones and builds Java projects
# PARAMETERS:
# 		$1 - Base URL/path to repository
# 		$2 - name of the project
# 		$3 - additional options to pass to gradle.  Optional - leave blank to disable.
##
cloneAndBuild() {
	git clone "${GITHUB}/${1}.git"
	pushd "$1" && \
	gradle build $2
	popd
}

mkdir -p "$GIT_DIR"
cd "$GIT_DIR"

## Setup general projects
repos=( "backup-utils" "bootstrap-course" "cheatsheet" "fastilybot-toolforge" "fcpx-presets" "ip-range-calc" "jinja2html" "jwiki-starter" "simple-commons-uploader" "stardew-valley-saves" "text2hash" )
for repo in "${repos[@]}"; do
	git clone "${GITHUB}/${repo}.git"
done

## Java projects
cloneAndBuild "jwiki" 'publishToMavenLocal -x test'
cloneAndBuild "wp-toolbox" 'publishToMavenLocal -x test'
cloneAndBuild "fastilybot"
cloneAndBuild "mtc"
cloneAndBuild "flabs"