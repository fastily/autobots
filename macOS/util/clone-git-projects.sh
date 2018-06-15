#!/bin/bash

#: Clones my git repositories for development.
#:
#: PRECONDITION:
#:		1) my ssh keys have been installed
#:
#: Author: Fastily

GIT_DIR=~/"Documents/git"
WORKSPACE_DIR=~/"Documents/workspace"

GITHUB='https://github.com/fastily'
BITBUCKET='git@bitbucket.org:fastily'

##
# Clones and builds Java projects
# PARAMETERS:
# 		$1 - Base URL/path to repository
# 		$2 - name of the project
# 		$3 - additional options to pass to gradle.  Optional - leave blank to disable.
##
cloneAndBuild() {
	cd "$WORKSPACE_DIR"

	git clone "${1}/${2}.git" && \
	cd "$2" && \
	gradle build $3

	cd "$WORKSPACE_DIR"
}


mkdir -p "$GIT_DIR" "$WORKSPACE_DIR"


## Setup general projects
cd "$GIT_DIR"
git clone "${GITHUB}/cli-notebook.git"
git clone "${GITHUB}/fastilybot-toollabs.git"


## Setup eclipse environment
cloneAndBuild "$GITHUB" "jwiki" 'publishToMavenLocal -x test'
cloneAndBuild "$GITHUB" "fastilybot" ':fastilybot-shared:publishToMavenLocal'
cloneAndBuild "$GITHUB" "mtc"
cloneAndBuild "$GITHUB" "mtc-rest"
cloneAndBuild "$GITHUB" "mw-oauth"

cloneAndBuild "$BITBUCKET" "code-puzzles"
cloneAndBuild "$BITBUCKET" "flabs"
cloneAndBuild "$BITBUCKET" "spring-course"