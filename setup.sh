#!/bin/bash

echo "Initial setup of dotfiles..."

CURRENT_DIR=$(pwd)

# Create file if it doesn't exist (nvm needs it to finish successfully)
touch ~/.bashrc

# Install `nvm`
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

