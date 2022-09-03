local log = require("mikemimik.log").new({ plugin = "cmp" })

local status, cmp = pcall(require, "cmp")
if (not status) then
  log.error("after/plugin.cmp.rc -- error")
  return
end

local snip_status, luasnip = pcall(require, "luasnip")
if (not snip_status) then return end

local kind_status, lspkind = pcall(require, "lspkind")
if (not kind_status) then return end

log.debug("after/plugin.cmp.rc -- loading")
cmp.setup({
  enabled = function()
    local context = require("cmp.config.context")
    if vim.api.nvim_get_mode().mode == "c" then
      return true
    else
      return not context.in_treesitter_capture("comment") and
          not context.in_treesitter_capture("Comment")
    end
  end,
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
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
    { name = "nvim_lsp", max_item_count = 3, keyword_length = 5 },
    { name = "buffer" },
  }),
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
  experimental = {
    ghost_text = false,
  },
})

-- vim.cmd([[
--   highlight! default link CmpItemKind  CmpItemMenuDefault
-- ]])

log.debug("after/plugin.cmp.rc -- loaded")
