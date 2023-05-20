/**
 * NOTE: Definition of Links
 * Each `key` in the returned object is a path to the specific source file
 * which should be linked. This path is *with respect to* the dotfiles
 * repository directory. Each `value` in the returned object is a path to the
 * target of the symlink. This path is *with respect to* the home directory.
 */
module.exports = {
  'apps/nvim/init.lua': '.config/nvim/init.lua',

  'apps/nvim/plugin/lspconfig.rc.lua': '.config/nvim/plugin/lspconfig.rc.lua',
  'apps/nvim/plugin/lspsaga.rc.lua': '.config/nvim/plugin/lspsaga.rc.lua',

  'apps/nvim/lua/mikemimik/init.lua': '.config/nvim/lua/mikemimik/init.lua',
  'apps/nvim/lua/mikemimik/keymap.lua': '.config/nvim/lua/mikemimik/keymap.lua',
  'apps/nvim/lua/mikemimik/log.lua': '.config/nvim/lua/mikemimik/log.lua',
  'apps/nvim/lua/mikemimik/mappings.lua': '.config/nvim/lua/mikemimik/mappings.lua',
  'apps/nvim/lua/mikemimik/plugins.lua': '.config/nvim/lua/mikemimik/plugins.lua',
  'apps/nvim/lua/mikemimik/treesitter.lua': '.config/nvim/lua/mikemimik/treesitter.lua',

  'apps/nvim/after/plugin/bufferline.rc.lua': '.config/nvim/after/plugin/bufferline.rc.lua',
  'apps/nvim/after/plugin/close-buffer.rc.lua': '.config/nvim/after/plugin/close-buffer.rc.lua',
  'apps/nvim/after/plugin/cmp.rc.lua': '.config/nvim/after/plugin/cmp.rc.lua',
  'apps/nvim/after/plugin/colors.rc.lua': '.config/nvim/after/plugin/colors.rc.lua',
  'apps/nvim/after/plugin/glow.rc.lua': '.config/nvim/after/plugin/glow.rc.lua',
  'apps/nvim/after/plugin/transparent.rc.lua': '.config/nvim/after/plugin/transparent.rc.lua',
  'apps/nvim/after/plugin/indentline.rc.lua': '.config/nvim/after/plugin/indentline.rc.lua',
  'apps/nvim/after/plugin/lspkind.rc.lua': '.config/nvim/after/plugin/lspkind.rc.lua',
  'apps/nvim/after/plugin/lualine.rc.lua': '.config/nvim/after/plugin/lualine.rc.lua',
  'apps/nvim/after/plugin/prettier.rc.lua': '.config/nvim/after/plugin/prettier.rc.lua',
  'apps/nvim/after/plugin/telescope.rc.lua': '.config/nvim/after/plugin/telescope.rc.lua',
  'apps/nvim/after/plugin/treesitter.rc.lua': '.config/nvim/after/plugin/treesitter.rc.lua',
  'apps/nvim/after/plugin/web-devicons.rc.lua': '.config/nvim/after/plugin/web-devicons.rc.lua',
  'apps/nvim/after/plugin/z-last.lua': '.config/nvim/after/plugin/z-last.lua',

  'apps/karabiner/karabiner.json': '.config/karabiner/karabiner.json',
  'apps/karabiner/assets/complex_modifications/local.json': '.config/karabiner/assets/complex_modifications/local.json',
  'apps/karabiner/assets/complex_modifications/q8.json': '.config/karabiner/assets/complex_modifications/q8.json',
  'apps/karabiner/assets/complex_modifications/okta-machine.json': '.config/karabiner/assets/complex_modifications/okta-machine.json',
  'apps/karabiner/assets/complex_modifications/personal-machine.json': '.config/karabiner/assets/complex_modifications/personal-machine.json',

  'apps/hammerspoon/Spoons': '.hammerspoon/Spoons',
  'apps/hammerspoon/init.lua': '.hammerspoon/init.lua',
  'apps/hammerspoon/inspect.lua': '.hammerspoon/inspect.lua',

  'apps/alacritty/alacritty.yml': '.config/alacritty/alacritty.yml',
  'apps/alacritty/colors.yml': '.config/alacritty/colors.yml',
  'apps/alacritty/config.yml': '.config/alacritty/config.yml',
  'apps/alacritty/font.yml': '.config/alacritty/font.yml',
  'apps/alacritty/keybindings.yml': '.config/alacritty/keybindings.yml',
  'apps/alacritty/window.yml': '.config/alacritty/window.yml',

  'apps/nvm/default-packages': '.nvm/default-packages',

  'apps/tmux/tmux.conf': '.config/tmux/tmux.conf',

  'dots/.agignore': '.agignore',
  'dots/.bash_aliases': '.bash_aliases',
  'dots/.bash_exports': '.bash_exports',
  'dots/.bash_functions': '.bash_functions',
  'dots/.bash_completion': '.bash_completion',
  'dots/.bash_profile': '.bash_profile',
  'dots/.bashrc': '.bashrc',
  'dots/.gitconfig': '.gitconfig',
  'dots/.git-prompt-colors.sh': '.git-prompt-colors.sh',
  // 'dots/.iterm2_shell_integration.sh': '.iterm2_shell_integration.sh',
}
