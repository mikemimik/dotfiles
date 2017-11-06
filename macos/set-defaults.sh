#!/bin/bash

#
# Reasonable set of macOS defaults. My sources:
# - https://github.com/nicksp/dotfiles/blob/master/osx/set-defaults.sh
#

# Set computer name
COMPUTERNAME="mperrotte"
HOSTNAME="mperrotte"
LOCALHOSTNAME="mperrotte"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set computer name (as done via System Preferences -> Sharing)
#sudo scutil --set ComputerName $COMPUTERNAME
#sudo scutil --set HostName $HOSTNAME
#sudo scutil --set LocalHostName $LOCALHOSTNAME
#sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $LOCALHOSTNAME

###############################################################################
# Interfaces: trackpad, mouse, keyboard, bluetooth, etc.                      #
###############################################################################

# Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

###############################################################################
# Finder                                                                      #
###############################################################################

# Show file extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Disable the warning when changing file extensions
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPa

###############################################################################
# Dock                                                                        #
###############################################################################

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Add several spacers
defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'

###############################################################################
# Do some clean up work.                                                      #
###############################################################################

for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
           "Dock" "Finder" "Mail" "Messages" "Safari" "SystemUIServer" \
           "Terminal" "Twitter" "iCal"; do
           kill all "${app}" > /dev/null 2>&1
done

# Wait a bit before moving on...
sleep 1

# ..and then.
echo "Success! Defaults are set."
echo "Some changes will not take effect until you reboot your machine."

# See if the user wants to reboot.
function reboot() {
  read -p "Do you want to reboot your computer now? (y/N)" choice
  case "$choice" in
    y | Yes | yes ) echo "Yes"; exit;; # If y | yes, reboot
    n | N | No | no) echo "No"; exit;; # If n | no, exit
    * ) echo "Invalid answer. Enter \"y/yes\" or \"N/no\"" && return;;
  esac
}

# Call on the function
if [[ "Yes" == $(reboot) ]]
then
  echo "Rebooting."
  sudo reboot
  exit 0
else
  exit 1
fi