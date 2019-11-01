#!/bin/bash

#### README ###################################################################
# 
# This file contains all the symlinks for all the files in `apps/${this_dir}`.
# Configuration files that are needed by each of of the apps (separated by
# folder) are symlinked or moved into their corresponding directory. If the
# application has an installation script (eg apps/vscode/extensions.sh) it will
# be executed.
#
###############################################################################

APP_NAME="karabiner"

# Karabiner Config Mapping
ln -sfv "${DOTFILES_DIR}/apps/${APP_NAME}/karabiner.json" "${HOME}/.config/${APP_NAME}/karabiner.json"

# NOTE: move these gitkeep files to create directory structure
ln -sfv "${DOTFILES_DIR}/apps/${APP_NAME}/assets/.gitkeep" "${HOME}/.config/${APP_NAME}/assets/.gitkeep"
ln -sfv "${DOTFILES_DIR}/apps/${APP_NAME}/assets/complex_modifications/.gitkeep" "${HOME}/.config/${APP_NAME}/assets/complex_modifications/.gitkeep"
