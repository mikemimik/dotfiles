local status, lspconfig = pcall(require, "lspconfig")
if (not status) then return end

local null_status, _ = pcall(require, "null-ls")
if (not null_status) then return end

-- print("plugin.lspconfig.rc -- loading")
local nnoremap = require("mikemimik.keymap").nnoremap
local xnoremap = require("mikemimik.keymap").xnoremap

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local common_attach = function(client, bufnr)
  local format_group = augroup("Format", { clear = true })
  local opts = { noremap = true, silent = true, buffer = bufnr }

  if client.server_capabilities.documentRangeFormattingProvider then
    -- keybinding for visual formatting (format section)
    xnoremap("<leader>f", function()
      vim.lsp.buf.range_formatting({})
    end, opts)
  end

  if client.server_capabilities.documentFormattingProvider then
    -- keybind for formatting
    nnoremap("<leader>f", function()
      vim.lsp.buf.formatting()
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

local capabilities = require("cmp_nvim_lsp").update_capabilities(
  protocol.make_client_capabilities()
)

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = capabilities,
    on_attach = common_attach,
  }, _config or {})
end

require("null-ls").setup({
  on_attach = common_attach,
  sources = {
    require("null-ls").builtins.completion.luasnip,
    require("null-ls").builtins.formatting.prettierd,
    require("null-ls").builtins.diagnostics.actionlint, -- requires https://github.com/rhysd/actionlint
    require("null-ls").builtins.code_actions.shellcheck, -- requires https://github.com/koalaman/shellcheck
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
    common_attach(client, bufnr)
  end,
  filetypes = { "typescript", "typscriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
}))

-- INFO: requires 'lua-language-server'
-- `brew install lua-language-server`
lspconfig.sumneko_lua.setup(config({
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

-- print("plugin.lspconfig.rc -- loaded")
