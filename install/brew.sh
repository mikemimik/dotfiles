#!/bin/bash

# NOTE(mperrotte): ask for sudo upfront
sudo -v

# NOTE(mperrotte): check for homebrew and install if missing
if [ test ! $(which brew) ]; then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap dart-lang/dart

# NOTE(mperrotte): make sure we're using the latest Homebrew
brew update

# NOTE(mperrotte): upgrade any already installed formulae
brew upgrade --all

##
# NOTE(mperrotte): Install packages I use on a day-to-day basis
#
##

apps=(
  nvm
  bash-git-prompt
  curl
  dart
  ffmpeg
  findutils
  git
  htop
  irssi
  python
  tree
  watson
  wget
)

brew install "${apps[@]}"

# NOTE(mperrotte): remove outdated versions
brew cleanup
