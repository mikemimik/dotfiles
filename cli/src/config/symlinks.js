/**
 * NOTE: Definition of Links
 * Each `key` in the returned object is a path to the specific source file
 * which should be linked. This path is *with respect to* the dotfiles
 * repository directory. Each `value` in the returned object is a path to the
 * target of the symlink. This path is *with respect to* the home directory.
 */
module.exports = {
  'apps/hammerspoon/init.lua': '.hammerspoon/init.lua',
  'apps/hammerspoon/inspect.lua': '.hammerspoon/inspect.lua',
  'dots/.agignore': '.agignore',
  'dots/.bash_aliases': '.bash_aliases',
  'dots/.bash_exports': '.bash_exports',
  'dots/.bash_functions': '.bash_functions',
  'dots/.bash_profile': '.bash_profile',
  'dots/.bashrc': '.bashrc',
  'dots/.gitconfig': '.gitconfig',
  'dots/.git-prompt-colors.sh': '.git-prompt-colors.sh',
  'dots/.iterm2_shell_integration.sh': '.iterm2_shell_integration.sh',
  'dots/.vimrc': '.vimrc',
}
