#!/bin/bash

# Install packages

CASK_LIST=$(brew cask list -1)

apps=(
  1password
  alfred
  amethyst                    # windows manager
  atom
  bartender
  dash
  discord
  # gyazo
  dropbox
  evernote
  # firefox
  firefox-developer-edition   # browser
  flux
  fly                         # concourse cli
  github                      # github desktop app
  google-chrome               # browser
  hammerspoon # automation scripting tool
  imageoptim
  insomnia                    # API tool
  iterm2
  itsycal                     # Calendar app
  kap                         # GIF generator
  karabiner-elements          # keyboard remapper
  logitech-options
  ngrok
  skype
  slack
  sourcetree
  spectacle                   # windows manager
  # kaleidoscope # diff tool
  spotify
  tableplus                   # database IDE tool
  # tower # git GUI tool
  virtualbox
  viscosity
  visual-studio-code
  vlc
  zoomus
)

for app in ${apps[@]}; do
  is_installed="false"
  for installed_app in ${CASK_LIST[@]}; do
    if [ ${app} == ${installed_app} ]; then
      echo "${app} already installed"
      is_installed="true"
      break
    fi
  done

  if [ "${is_installed}" == "false" ]; then
    brew cask install ${app}
  fi
done

# NOTE(mperrotte): remove outdated versions
brew cleanup
