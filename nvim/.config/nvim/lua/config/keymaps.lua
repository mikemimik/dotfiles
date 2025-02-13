local nmap = require("utils.keymap").nmap
local vmap = require("utils.keymap").vmap
local xmap = require("utils.keymap").xmap
local imap = require("utils.keymap").imap

-- Keymapping
imap("<leader>,", "<esc><right>")
xmap("<leader>,", "<esc><right>")

-- Yanking
xmap("<leader>y", '"*y"') -- yank to system clipboard
nmap("<leader>p", '"*p') -- paste from system clipboard
imap("<leader>p", '<c-o>"*p') -- paste from system clipboard
xmap("<leader>p", '"*p') -- paste from system clipboard

-- Move lines up and down
nmap("<s-j>", ":m .+1<cr>==")
nmap("<s-k>", ":m .-2<cr>==") -- this doesn't work; a plugin overwrites it
vmap("<s-j>", ":m '>+1<cr>gv=gv")
vmap("<s-k>", ":m '<-2<cr>gv=gv")

-- Search word under cursor
nmap("#", function()
  local current_word = vim.call("expand", "<cword>")
  vim.fn.setreg("/", current_word)
  vim.opt.hlsearch = true
end, { silent = true })
-- remove highlighting from search
nmap("<right>", ":noh<cr>", { silent = true })
