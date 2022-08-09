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
brew upgrade

##
# NOTE(mperrotte): Install packages I use on a day-to-day basis
#
##

BREW_LIST=$(brew list -1)

apps=(
  awscli
  bash
  bash-completion@2
  bash-git-prompt
  bat
  # brew-graph
  colordiff
  coreutils
  curl
  diff-so-fancy
  diffutils
  dnsmasq
  # dart
  # dep
  findutils
  fzf
  fish
  gawk
  gcc
  gh
  git
  gnu-sed
  gnu-tar
  go
  heroku/brew/heroku
  htop
  iftop
  irssi
  jq
  kubernetes-cli
  kubernetes-helm
  ncdu
  openssl
  python@3.9
  tree
  ruby
  siege
  telnet
  terraform
  the_silver_searcher
  tmux
  tree
  watson
  wget
  wifi-password
  # NOTE: need to install node first; or it default intalls `node` from homebrew
  # yarn
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
