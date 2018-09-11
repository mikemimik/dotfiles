#!/bin/bash

echo "Initial setup of dotfile config / command..."
cp ~/dotfiles/shell/bashrc ~/.bashrc
cp ~/dotfiles/shell/bash_profile ~/.bash_profile
cp ~/dotfiles/shell/bash_aliases ~/.bash_aliases
cp ~/dotfiles/shell/bash_functions ~/.bash_functions

echo "Initial setup of dotfile config complete."
echo "Usage: dotfiles --help"
