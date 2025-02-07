#!/usr/bin/env bash

echo "Initial setup of dotfiles..."

if [[ -z ${STOW_FOLDERS} ]]
then
  STOW_FOLDERS="ag alacritty bash git hammerspoon karabiner nvm tmux"
fi

if [[ -z ${DOTFILES} ]]
then
  DOTFILES="${HOME}/dotfiles"
fi

cd "${DOTFILES}" || return

for folder in ${STOW_FOLDERS}
do
  echo "stow ${folder}"
  stow -D "${folder}"
  stow "${folder}"
done

echo "Initial setup of dotfiles complete."
# echo "Usage: dot-cli --help"
