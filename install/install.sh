export DOTFILES_DIR EXTRA_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd .. && pwd )"

# Install brew with packages & casks
echo "Installing brews..."
. "$DOTFILES_DIR/install/brew.sh"

# Install brew cask packages
echo "Installing casks..."
. "$DOTFILES_DIR/install/brew-cask.sh"

# Bunch of symlinks
echo "Symlinking files..."
. "$DOTFILES_DIR/install/symlinks.sh"

# Add keys from keychain to ssh agent
ssh-add -A 2>/dev/null;

# Clear cache
# echo "Cleaning up..."
# . "$DOTFILES_DIR/bin/dot-cli" clean

# Setup dock icons
# echo "Executing macOS dock script..."
# . "$DOTFILES_DIR/macos/dock.sh"

# Setup macos defaults (causes restart, must be last action)
echo "Executing macOS defaults script..."
. "$DOTFILES_DIR/macos/defaults.sh"