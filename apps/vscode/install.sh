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

# VSCODE Snippet mapping
vscode_snippets=$(ls ${DOTFILES_DIR}/apps/vscode/snippets)
for snippet in ${vscode_snippets}; do
  ln -sfv "${DOTFILES_DIR}/apps/vscode/snippets/${snippet}" "${HOME}/Library/Application Support/Code/User/snippets"
done
ln -sfv "${DOTFILES_DIR}/apps/vscode/keybindings.json" "${HOME}/Library/Application Support/Code/User"
ln -sfv "${DOTFILES_DIR}/apps/vscode/settings.json" "${HOME}/Library/Application Support/Code/User"

# VSCODE extensions
. ${DOTFILES_DIR}/apps/vscode/extensions.sh
