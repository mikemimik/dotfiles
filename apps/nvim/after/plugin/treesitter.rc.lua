local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

-- print("after/plugin.treesitter.rc -- loading")
ts.setup {
  ensure_installed = {
    "yaml",
    "json",
    "tsx",
    "javascript",
    "go",
    "make",
    "markdown",
  },
  sync_install = false,
  -- requires `tree-sitter` cli installed
  auto_install = true,

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- Folding
-- vim.opt.foldenable = true
-- vim.opt.foldcolumn = "9"
vim.opt.foldlevel = 10
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- print("after/plugin.treesitter.rc -- loaded")
