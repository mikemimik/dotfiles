local status, saga = pcall(require, "lspsaga")
if (not status) then return end

-- print("plugin.lspsaga.rc -- loading")
local nnoremap = require("mikemimik.keymap").nnoremap

saga.setup({
  lightbulb = {
    enable = false,
    enable_in_insert = false,
  },
})
-- saga.init_lsp_saga({
--   server_filetype_map = {
--     typescript = "typescript",
--   },
--   code_action_lightbulb = {
--     enable = false,
--     enable_in_insert = false,
--   },
-- })

local opts = { silent = true }
-- INFO: collides with <s-k>
-- nnoremap("K", ":Lspsaga hover_doc<cr>", opts)
nnoremap("gd", ":Lspsaga lsp_finder<cr>", opts)
nnoremap("]1", ":Lspsaga diagnostic_jump_next<cr>", opts)
nnoremap("[1", ":Lspsaga diagnostic_jump_prev<cr>", opts)

-- print("plugin.lspsaga.rc -- loaded")
