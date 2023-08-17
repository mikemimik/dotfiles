-- print("mikemimik.mappings -- loading")
local Remap = require("mikemimik.keymap")
local nnoremap = Remap.nnoremap
local vnoremap = Remap.vnoremap
local inoremap = Remap.inoremap
local xnoremap = Remap.xnoremap

vim.g.mapleader = ","

-- exit->normal
vim.keymap.set("i", "<leader>,", "<esc><right>", { noremap = true })

inoremap("<leader>,", "<esc><right>")
xnoremap("<leader>,", "<esc><right>")

xnoremap("<leader>y", '"*y"') -- yank to system clipboard

nnoremap("<leader>p", '"*p') -- paste from system clipboard
inoremap("<leader>p", '<c-o>"*p') -- paste from system clipboard
xnoremap("<leader>p", '"*p') -- paste from system clipbard

nnoremap("<right>", ":noh<cr>", { silent = true })
nnoremap("<leader><tab>", ":Ex<cr>")

nnoremap("<leader>wl", "<c-w><right>")
nnoremap("<leader>wh", "<c-w><left>")
nnoremap("<leader>wj", "<c-w><down>")
nnoremap("<leader>wk", "<c-w><up>")

-- move lines up and down
nnoremap("<s-j>", ":m .+1<cr>==")
nnoremap("<s-k>", ":m .-2<cr>==")
vnoremap("<s-j>", ":m '>+1<cr>gv=gv")
vnoremap("<s-k>", ":m '<-2<cr>gv=gv")

nnoremap("<up>", "<c-y>")
nnoremap("<down>", "<c-e>")

-- resize splits
nnoremap("<leader>rh", ":vert resize -5<cr>")
nnoremap("<leader>rl", ":vert resize +5<cr>")
nnoremap("<leader>rk", ":resize -5<cr>")
nnoremap("<leader>rj", ":resize +5<cr>")
nnoremap("<leader>rf", "<c-w>_<c-w>|")
nnoremap("<leader>re", "<c-w>=")

-- search word under cursor
nnoremap(
  "#",
  function()
    local current_word = vim.call("expand", "<cword>")
    vim.fn.setreg('/', current_word)
    vim.opt.hlsearch = true
  end,
  { silent = true }
)

-- print("mikemimik.mappings -- loaded")
