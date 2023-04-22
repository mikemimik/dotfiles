-- print("mikemimik.plugins -- loading")

local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim",
    install_path })
  vim.cmd("packadd packer.nvim")
end

local packer = require("packer")
-- packer.init({
--   auto_reload_compiled = true,
-- })

return packer.startup(function(use)
  -- Default
  use("wbthomason/packer.nvim")
  use("tjdevries/vlog.nvim")

  -- Visualizations
  use("junegunn/seoul256.vim")
  use("nvim-tree/nvim-web-devicons")
  -- requires patched font with glyps
  use({
    "akinsho/bufferline.nvim",
    tag = "v3.*",
    requires = 'nvim-tree/nvim-web-devicons'
  })
  use("Yggdroot/indentLine")
  use("nvim-lualine/lualine.nvim")
  use({
    "ellisonleao/glow.nvim"
    -- requires 'glow' (brew install)
  })
  use({ "xiyaowong/transparent.nvim" })

  -- Functionality
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
    -- requires 'tree-sitter' (brew install)
  })
  use({ "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } }
    -- requires 'ripgrep' (brew install)
  })
  use("nvim-telescope/telescope-file-browser.nvim")
  use("tpope/vim-commentary")
  use("tpope/vim-fugitive")
  use("kazhala/close-buffers.nvim")

  -- LSP Configuration
  use({
    "neovim/nvim-lspconfig"
    -- requires 'lua-language-server' (brew install)
    -- requires 'typescript-language-server' (npm i -g)
  }) -- LSP
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/nvim-cmp")
  use("hrsh7th/cmp-nvim-lua")
  use("L3MON4D3/LuaSnip")
  use({
    -- TODO: figure out how to utilise correctly
    "glepnir/lspsaga.nvim",
    branch = "main",
  })
  use("jose-elias-alvarez/null-ls.nvim")
  use("onsails/lspkind-nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end

  -- print("mikemimik.plugins -- loaded")
end)
