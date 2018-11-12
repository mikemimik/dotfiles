
ln -sfv "$DOTFILES_DIR/dots/.git-prompt-colors.sh" ~
ln -sfv "$DOTFILES_DIR/dots/.bash_exports" ~
ln -sfv "$DOTFILES_DIR/dots/.bash_functions" ~
ln -sfv "$DOTFILES_DIR/dots/.bash_aliases" ~
ln -sfv "$DOTFILES_DIR/dots/.bash_profile" ~
ln -sfv "$DOTFILES_DIR/dots/.bashrc" ~

# ln -sfv "$DOTFILES_DIR/dots/.gitconfig" ~
# ln -sfv "$DOTFILES_DIR/dots/.gitignore_global" ~
# ln -sfv "$DOTFILES_DIR/dots/.inputrc" ~

# VSCODE Snippet mapping
vscode_snippets=$(ls ${DOTFILES_DIR}/vscode/snippets)
for snippet in ${vscode_snippets}; do
  ln -sfv "${DOTFILES_DIR}/vscode/snippets/${snippet}" "${HOME}/Library/Application Support/Code/User/snippets"
done
ln -sfv "${DOTFILES_DIR}/vscode/keybindings.json" "${HOME}/Library/Application Support/Code/User"
ln -sfv "${DOTFILES_DIR}/vscode/settings.json" "${HOME}/Library/Application Support/Code/User"

# Exmaples for mapping
# ln -sfv "$DOTFILES_DIR/editors/Default (OSX).sublime-keymap" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Default (OSX).sublime-keymap"
# ln -sfv "$DOTFILES_DIR/editors/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
# ln -sfv "$DOTFILES_DIR/oh-my-zsh/themes/taybalt.zsh-theme" ~/.oh-my-zsh/themes