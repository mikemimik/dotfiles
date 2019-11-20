#!/bin/bash

#### README ###################################################################
#
# This file contains all the symlinks for all the files in `dots/`
#
###############################################################################

ln -sfv "$DOTFILES_DIR/dots/.git-prompt-colors.sh" ~
ln -sfv "$DOTFILES_DIR/dots/.bash_exports" ~
ln -sfv "$DOTFILES_DIR/dots/.bash_functions" ~
ln -sfv "$DOTFILES_DIR/dots/.bash_aliases" ~
ln -sfv "$DOTFILES_DIR/dots/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/dots/.bashrc" ~

ln -sfv "$DOTFILES_DIR/dots/.vimrc" ~
ln -sfv "$DOTFILES_DIR/dots/.gitconfig" ~
ln -sfv "$DOTFILES_DIR/dots/.iterm2_shell_integration.sh" ~
# ln -sfv "$DOTFILES_DIR/dots/.gitignore_global" ~
# ln -sfv "$DOTFILES_DIR/dots/.inputrc" ~
