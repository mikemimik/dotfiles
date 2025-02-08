
-- Leader
vim.g.mapleader = ","

-- Config
-- Behaviours
vim.opt.timeoutlen = 200
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.swapfile = false
vim.opt.backspace = { "indent", "eol", "start" }

-- Indentation
vim.opt.tabstop = 2         -- <Tab> appears as 2 spaces
vim.opt.shiftwidth = 2      -- >>, << shift line by 2 spaces
vim.opt.softtabstop = 2     -- <Tab> behaves like 2 spaces when editing
vim.opt.autoindent = true   -- continue indentation to new line
vim.opt.expandtab = true    -- <Tab> inserts spaces

-- Look & Feel
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.colorcolumn = "+1"
vim.opt.laststatus = 2
vim.opt.list = false        -- show list characters
vim.opt.listchars = {
    -- these list characters
    tab = ">-",
    eol = "$",
    space = ".",
}
vim.opt.scrolloff = 10      -- padding between cursor and top/bottom of window
vim.opt.splitright = true   -- prefer vsplitting to the right
vim.opt.splitbelow = true   -- prefer splitting below
vim.opt.textwidth = 80
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.hlsearch = true