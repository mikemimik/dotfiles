local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

-- print("after/plugin.treesitter.rc -- loading")
ts.setup {
  ensure_installed = {
    "yaml",
    "json",
    "tsx",
    "javascript",
  },
  sync_install = false,
  -- requires `tree-sitter` cli installed
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- print("after/plugin.treesitter.rc -- loaded")
