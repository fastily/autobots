#!/usr/bin/env bash

##
#: Creates a python venv in the current working directory with a name based on the current working directory.
#:
#: PARAMETERS:
#: 		$1 - Use custom name for venv
#:
#: Author: Fastily
##

VENV_NAME="${1:-"venv_$(basename "$PWD" | tr -- '- ' '_')"}"
echo "[INFO]: Creating venv with name '${VENV_NAME}'..."
python3 -m venv "$VENV_NAME"