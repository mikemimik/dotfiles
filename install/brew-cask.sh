#!/bin/bash

# Install packages
apps=(
    1password
    # gyazo
    dropbox
    spectacle
    flux
    dash
    imageoptim
    evernote
    iterm2
    atom
    # firefox
    google-chrome
    hammerspoon # automation scripting tool
    # kaleidoscope # diff tool
    spotify
    skype
    slack
    # tower # git GUI tool
)

brew cask install "${apps[@]}"

# NOTE(mperrotte): remove outdated versions
brew cleanup
