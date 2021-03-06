#!/bin/bash

# Install packages

CASK_LIST=$(brew cask list -1)


system_security_privacy_apps=(
  alfred
  bartender
  homebrew/cask-drivers/logitech-options
  spectacle                   # windows manager
)

user_action_apps=(
  1password
  dash
  docker
  dropbox
  hammerspoon                 # automation scripting tool
  iterm2
)

apps=(
  amethyst                    # windows manager
  # atom
  # datagrip
  discord
  # gyazo
  evernote
  # firefox
  homebrew/cask-versions/firefox-developer-edition   # browser
  flux
  fly                         # concourse cli
  github                      # github desktop app
  google-chrome               # browser
  insomnia                    # API tool
  itsycal                     # Calendar app
  kap                         # GIF generator
  karabiner-elements          # keyboard remapper
  kitematic
  ngrok
  skype
  slack
  # sourcetree
  # kaleidoscope                # diff tool
  spotify
  sublime-text
  tableplus                   # database IDE tool
  # tower                       # git GUI tool
  viscosity
  visual-studio-code
  vlc
  whatsapp
  zoomus
)

for app in ${apps[@]}; do
  is_installed="false"
  for installed_app in ${CASK_LIST[@]}; do
    # INFO(mperrotte): split the app name to see if it's a tap
    IFS="/" read -ra splitApp <<< "${app}"
    if [ "${#splitApp[@]}" == 1 ]; then
      if [ ${app} == ${installed_app} ]; then
        echo "${app} already installed"
        is_installed="true"
        break
      fi
    else
      lastIndex=${#splitApp[@]}
      # INFO(mperrotte): get last index value
      appName=${splitApp[lastIndex-1]}
      if [ "${appName}" == "${installed_app}" ]; then
        echo "${app} already installed"
        is_installed="true"
        break
      fi
    fi
  done

  if [ "${is_installed}" == "false" ]; then
    brew cask install ${app}
  fi
done

echo ">>> Installing casks which REQUIRE USER ACTION..."
echo ""

# INFO(mperrotte): iterate a second time for apps that need user action
for app in ${user_action_apps[@]}; do
  is_installed="false"
  for installed_app in ${CASK_LIST[@]}; do
    # INFO(mperrotte): split the app name to see if it's a tap
    IFS="/" read -ra splitApp <<< "${app}"
    if [ "${#splitApp[@]}" == 1 ]; then
      if [ ${app} == ${installed_app} ]; then
        echo "${app} already installed"
        is_installed="true"
        break
      fi
    else
      lastIndex=${#splitApp[@]}
      # INFO(mperrotte): get last index value
      appName=${splitApp[lastIndex-1]}
      if [ "${appName}" == "${installed_app}" ]; then
        echo "${app} already installed"
        is_installed="true"
        break
      fi
    fi
  done

  if [ "${is_installed}" == "false" ]; then
    # TODO(mperrotte): add pause so user can take action
    brew cask install ${app}
    # read -n 1 -p "Press enter to continue."
  fi
done

# NOTE(mperrotte): remove outdated versions
brew cleanup
