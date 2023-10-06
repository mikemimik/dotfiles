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
  use("nvim-lua/plenary.nvim")

  -- Visualizations
  use("shaunsingh/seoul256.nvim")
  use("nvim-tree/nvim-web-devicons")
  -- requires patched font with glyps
  use({
    "akinsho/bufferline.nvim",
    tag = "v4.*",
    requires = "nvim-tree/nvim-web-devicons"
  })
  use("Yggdroot/indentLine")
  use("nvim-lualine/lualine.nvim")
  use({
    "ellisonleao/glow.nvim"
    -- requires "glow" (brew install)
  })
  use({ "xiyaowong/transparent.nvim" })
  use({
    'samueljoli/hurl.nvim',
    config = function()
      require('hurl').setup({
        comment          = "#ebc021", -- default => Comment
        method           = "#fffc58", -- default => Statement
        url              = "#fffc58", -- default => Underlined
        version          = "#032ea7", -- default => Statement
        status           = "#032ea7", -- default => Number
        section          = "#032ea7", -- default => Statement
        operators        = "#c592ff", -- default => Operator
        string           = "#032ea7", -- default => String
        query            = "#d57bff", -- default => Identifier
        filter           = "#032ea7", -- default => Operator
        predicate        = "#032ea7", -- default => Operator
        template         = "#032ea7", -- default => Identifier
        escapeQuote      = "#032ea7", -- default => SpecialChar
        escapeNumberSign = "#032ea7", -- default => SpecialChar
      })
    end
  })

  -- Functionality
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate"
    -- requires "tree-sitter" (brew install)
  })
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } }
    -- requires "ripgrep" (brew install)
  })
  use("nvim-telescope/telescope-file-browser.nvim")
  use("tpope/vim-commentary")
  use("tpope/vim-fugitive")
  use("kazhala/close-buffers.nvim")
  use({
    "nvim-treesitter/nvim-treesitter-context",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        -- separator = "-",
        zindex = 20,
      })
    end,
  })

  -- LSP Configuration
  use({
    "VonHeikemen/lsp-zero.nvim",
    -- TODO: September 20, 2023 this will be set
    -- branch = "v3.x",
    branch = "dev-v3",
    requires = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      -- { "williamboman/mason.nvim" },           -- Optional
      -- { "williamboman/mason-lspconfig.nvim" }, -- Optional

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },     -- Required
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" }, -- Required
    }
  })
  -- use({
  --   "mrded/nvim-lsp-notify",
  --   config = function()
  --     require("lsp-notify").setup({})
  --   end
  -- })
  -- use("hrsh7th/cmp-nvim-lua")
  -- use("L3MON4D3/LuaSnip") -- to be deleted
  -- use({
  --   -- TODO: figure out how to utilise correctly
  --   "nvimdev/lspsaga.nvim",
  --   after = "nvim-lspconfig",
  --   branch = "main",
  -- })
  use("jose-elias-alvarez/null-ls.nvim")
  use("onsails/lspkind-nvim")

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    packer.sync()
  end

  -- print("mikemimik.plugins -- loaded")
end)
