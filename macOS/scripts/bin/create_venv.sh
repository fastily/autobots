#!/usr/bin/env bash

##
#: Creates a python venv in the current working directory with a name based on the current working directory.
#: 
#: Author: Fastily
##

VENV_NAME="$(basename "$PWD" | tr --  "- " "_")"
echo "Creating venv with name ${VENV_NAME}..."
python3 -m venv "venv_${VENV_NAME}"