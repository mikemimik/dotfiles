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
  bat
  curl
  dart
  ffmpeg
  findutils
  gawk
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
    # INFO(mperrotte): split the app name to see if it's a tap
    IFS="/" read -ra splitApp <<< "${app}"
    if [ "${#splitApp[@]}" == 1 ]; then
      # INFO(mperrotte): if name length == 1, regular formula
      if [ ${app} == ${installed_app} ]; then
        echo "${app} already installed"
        is_installed="true"
        break
      fi
    else
      lastIndex=${#splitApp[@]}
      # INFO(mperrotte): get last index value
      appName=${splitApp[lastIndex-1]}
      if [ ${appName} == ${installed_app} ]; then
        echo "${app} already installed"
        is_installed="true"
        break
      fi
    fi

  done

  if [ "${is_installed}" == "false" ]; then
    brew install ${app}
  fi
done

# NOTE(mperrotte): nvm has some specific needs
is_nvm_installed="false"
for installed_app in ${BREW_LIST[@]}; do
  if [ "nvm" == ${installed_app} ]; then
    echo "nvm is already installed"
    is_nvm_installed="true"
    break
  fi
done

if [ "${is_nvm_installed}" == "false" ]; then
  brew install nvm
  export NVM_DIR="$HOME/.nvm"
  source /usr/local/opt/nvm/nvm.sh
fi

# NOTE(mperrotte): remove outdated versions
brew cleanup
