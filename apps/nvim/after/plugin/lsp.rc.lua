local log = require("mikemimik.log").new({ plugin = "lsp" })

local lsp_status, lsp = pcall(require, "lsp-zero")
if (not lsp_status) then return end

lsp.preset({})

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if (not lspconfig_status) then return end

local util_status, util = pcall(require, "lspconfig/util")
if (not util_status) then return end

lsp.extend_cmp()

local nnoremap = require("mikemimik.keymap").nnoremap
local xnoremap = require("mikemimik.keymap").xnoremap

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local format_group = augroup("LspFormatting", {})

lsp.on_attach(function(client, bufnr)
  -- log.info("lsp.on_attach:client", client.name)
  lsp.default_keymaps({ buffer = bufnr })

  -- Format current buffer
  nnoremap("<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end)
  -- Format current highlighted section
  xnoremap("<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end)
  -- Format on save
  autocmd({ "BufWritePre" }, {
    group = format_group,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
      -- NOTE: need to reset visible diagnostics in buffer
      -- vim.diagnostic.show()
    end,
  })

  nnoremap("]1", function()
    vim.diagnostic.goto_next()
  end)
  nnoremap("[1", function()
    vim.diagnostic.goto_prev()
  end)
end)

-- cmp specific config
local cmp_status, cmp = pcall(require, "cmp")
if (not cmp_status) then return end

local kind_status, lspkind = pcall(require, "lspkind")
if (not kind_status) then return end

lspkind.init({
  mode = "symbol",
  preset = "default",
  symbol_map = {
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
  },
})

local luasnip_status, luasnip = pcall(require, "luasnip")
if (not luasnip_status) then return end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol",
      maxwidth = 50,
      menu = {
        nvim_lua = "[nvim]",
        nvim_lsp = "[LSP]",
        buffer = "[buffer]",
      },
    }),
  },
  window = {
    completion = cmp.config.window.bordered({
      col_offset = 2,
    }),
    documentation = cmp.config.window.bordered({
      col_offset = 2,
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ["<esc>"] = cmp.mapping.abort(),
    ["<cr>"] = cmp.mapping.confirm({
      -- TODO: determine what this does
      -- behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lua" },
    -- { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "nvim_lsp", max_item_count = 3, keyword_length = 5 },
    { name = "buffer" },
  }),
})

-- Language Server Configurations
lspconfig.lua_ls.setup(lsp.nvim_lua_ls({
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

lspconfig.tsserver.setup({
  filetypes = { "typescript", "typscriptreact", "typescript.tsx" },
  -- cmd = { "typescript-language-server", "--stdio" },
})

-- lsp.setup_servers({ "tsserver" })

local null_status, null_ls = pcall(require, "null-ls")
if (not null_status) then return end

null_ls.setup({
  sources = {
    null_ls.builtins.completion.luasnip,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.buf,          -- requires https://github.com/bufbuild/buf
    null_ls.builtins.diagnostics.buf,         -- requires https://github.com/bufbuild/buf
    null_ls.builtins.diagnostics.actionlint,  -- requires https://github.com/rhysd/actionlint
    null_ls.builtins.diagnostics.shellcheck,  -- requires https://github.com/koalaman/shellcheck
    null_ls.builtins.code_actions.shellcheck, -- requires https://github.com/koalaman/shellcheck
  },
})
