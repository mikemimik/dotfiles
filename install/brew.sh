#!/bin/bash

# NOTE(mperrotte): ask for sudo upfront
sudo -v

# NOTE(mperrotte): check for homebrew and install if missing
if [ ! $(which brew) ]; then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Homebrew already installed..."
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

BREW_LIST=$(brew list -1)

apps=(
  awscli
  bash-git-prompt
  curl
  dart
  ffmpeg
  findutils
  git
  go
  heroku/brew/heroku
  htop
  hyper
  iftop
  irssi
  jq
  kubernetes-cli
  kubernetes-helm
  nvm
  openssl
  python
  tree
  ruby
  telnet
  terraform
  watson
  wget
)

for app in ${apps[@]}; do
  is_installed="false"
  for installed_app in ${BREW_LIST[@]}; do
    if [ ${app} == ${installed_app} ]; then
      echo "${app} already installed"
      is_installed="true"
      break
    fi
  done

  if [ "${is_installed}" == "false" ]; then
    brew install ${app}
  fi
done

# NOTE(mperrotte): remove outdated versions
brew cleanup
