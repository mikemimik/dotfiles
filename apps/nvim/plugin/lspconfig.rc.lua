local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end

local util_status, util = pcall(require, "lspconfig/util")
if (not util_status) then return end

local null_status, null_ls = pcall(require, "null-ls")
if (not null_status) then return end

local log = require("mikemimik.log").new({ plugin = "lspconfig" })

-- print("plugin.lspconfig.rc -- loading")
local nnoremap = require("mikemimik.keymap").nnoremap
local xnoremap = require("mikemimik.keymap").xnoremap

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local common_attach = function(client, bufnr)
  local format_group = augroup("Format", { clear = true })
  local opts = {
    noremap = true,
    silent = true,
    buffer = bufnr,
  }

  if client.server_capabilities.documentRangeFormattingProvider then
    -- keybinding for visual formatting (format section)
    xnoremap("<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end

  if client.server_capabilities.documentFormattingProvider then
    -- keybind for formatting
    nnoremap("<leader>f", function()
      vim.lsp.buf.format({ async = true })
      log.info("buf", bufnr, "client", client.name)
    end, opts)

    -- format on save
    autocmd("BufWritePre", {
      group = format_group,
      buffer = bufnr,
      callback = function()
        -- vim.lsp.buf.formatting()
        vim.lsp.buf.format({
          filter = function(f_client)
            return f_client.name == "null_ls"
          end,
          bufnr = bufnr,
        })
      end,
    })

    autocmd("BufWritePre", {
      pattern = "*.go",
      callback = function()
        vim.lsp.buf.code_action({
          context = {
            only = { 'source.organizeImports' },
          },
          apply = true,
        })
      end,
    })
  end
end

local protocol = require("vim.lsp.protocol")
protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = common_attach,
  }, _config or {})
end

null_ls.setup({
  on_attach = common_attach,
  sources = {
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.diagnostics.actionlint, -- requires https://github.com/rhysd/actionlint
    null_ls.builtins.code_actions.shellcheck, -- requires https://github.com/koalaman/shellcheck
    null_ls.builtins.diagnostics.shellcheck, -- requires https://github.com/koalaman/shellcheck
  },
})

-- INFO: requires 'typescript-language-server'
-- `npm i -g typescript-language-server`
lspconfig.tsserver.setup(config({
  on_attach = function(client, bufnr)
    -- client.resolved_capabilities.document_formatting = false
    -- client.server_capabilities.documentFormattingProvider = false

    -- -- format on save
    -- autocmd("BufWritePre", {
    --   -- group = format_group,
    --   buffer = bufnr,
    --   callback = function()
    --     vim.lsp.buf.formatting()
    --   end,
    -- })
    -- common_attach(client, bufnr)
  end,
  filetypes = { "typescript", "typscriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
}))

-- INFO: requires 'lua-language-server'
-- `brew install lua-language-server`
lspconfig.lua_ls.setup(config({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "hs", "spoon" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
    },
  },
}))

-- INFO: requires "Go language server"
-- `brew install gopls`
lspconfig.gopls.setup({
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = false,
    },
  },
})

-- print("plugin.lspconfig.rc -- loaded")
