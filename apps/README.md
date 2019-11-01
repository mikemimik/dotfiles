
## Apps Folder

Each folder in this directory represents an application that as some safed
confiuration or additional installation steps.

### Setup

Each folder must include an `install.sh` file which has whatever logic is
required to install this applications configuration. This install file should
never be run specifically. It should always be executed by the `dotfiles` cli.

#### Environment

The `install.sh` file will have the following environment variables available
to it while executing.

* `DOTFILES_DIR`: the absolute path to the directory where the dotfiles have
been cloned to.

#### Exmaples for mapping
```
ln -sfv "$DOTFILES_DIR/editors/Default (OSX).sublime-keymap" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Default (OSX).sublime-keymap"
```
```
ln -sfv "$DOTFILES_DIR/editors/Preferences.sublime-settings" "$HOME/Library/Application Support/Sublime Text 3/Packages/User/Preferences.sublime-settings"
```
```
ln -sfv "$DOTFILES_DIR/oh-my-zsh/themes/taybalt.zsh-theme" ~/.oh-my-zsh/themes
```
