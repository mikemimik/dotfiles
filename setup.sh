#!/usr/bin/env bash

echo "Initial setup of dotfiles..."

if [[ -z ${DOTFILES} ]]; then
  DOTFILES="${HOME}/dotfiles"
fi

# INFO: stow configuration files
if [[ -z ${STOW_FOLDERS} ]]; then
  STOW_FOLDERS="ag alacritty bash git hammerspoon karabiner nvm nvim tmux"
fi

cd "${DOTFILES}" || return

for folder in ${STOW_FOLDERS}; do
  echo "stow ${folder}"
  stow -D "${folder}"
  stow "${folder}"
done

# INFO: Setup system fonts

cp -R ${DOTFILES}/fonts/ ~/Library/Fonts/

# INFO: Update dotfiles repo from 'https' to 'ssh'
cd "${DOTFILES}" || return

IFS='/' read -ra PARTS <<<"$(git remote -vv | awk '{ print $2}')"
DOMAIN="${PARTS[2]}"
USERNAME="${PARTS[3]}"
REPOSITORY="${PARTS[4]}"

git remote set-url origin "git@${DOMAIN}:${USERNAME}/${REPOSITORY}"

# INFO: Setup submodules
cd "${DOTFILES}" || return

git submodule update --init --recursive

echo "Initial setup of dotfiles complete."
