-- print("mikemimik.init -- loading")
require("mikemimik.mappings")
require("mikemimik.plugins")

-- Essentials
vim.opt.timeoutlen = 200

-- Behaviours
vim.opt.belloff = "hangul"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.swapfile = false
vim.opt.mouse = "a"
vim.opt.backspace = { "indent", "eol", "start" }

-- Indentation
vim.opt.tabstop = 2       -- <Tab> appears as 2 spaces
vim.opt.shiftwidth = 2    -- >>, << shift line by 2 spaces
vim.opt.softtabstop = 2   -- <Tab> behaves like 2 spaces when editing
vim.opt.autoindent = true -- continue indentation to new line
vim.opt.expandtab = true  -- <Tab> inserts spaces

-- Look & Feel
vim.opt.number = true
vim.opt.relativenumber = true
-- https://vi.stackexchange.com/questions/422/displaying-tabs-as-characters
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.colorcolumn = "+1"
vim.opt.laststatus = 2
-- vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20" -- default
-- vim.opt.foldcolumn = 1
vim.opt.foldmethod = "syntax"
vim.opt.list = false -- show list characters
vim.opt.listchars = {
  -- these list characters
  tab = ">-",
  eol = "$",
  space = ".",
}
vim.opt.scrolloff = 10    -- padding between cursor and top/bottom of window
vim.opt.splitright = true -- prefer vsplitting to the right
vim.opt.splitbelow = true -- prefer splitting below
vim.opt.textwidth = 80
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true

-- Colours
vim.opt.termguicolors = true

-- Searching
vim.opt.hlsearch = true

-- AUTOCMDs
local augroup = vim.api.nvim_create_augroup
local baseGroup = augroup("base", {})

local autocmd = vim.api.nvim_create_autocmd

-- NOTE: trims whitespace from buffer
autocmd({ "BufWritePre" }, {
  group = baseGroup,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- NOTE: format "env" files as `sh` syntax
autocmd({ "BufNewFile", "BufRead" }, {
  group = baseGroup,
  pattern = "*.env.*",
  callback = function()
    vim.opt.syntax = "sh"
  end,
})

-- NOTE: auto equalise panes when vim is resized
autocmd({ "VimResized" }, {
  group = baseGroup,
  pattern = "*",
  command = "wincmd =",
})

-- NOTE: configure TreesitterContextBottom
autocmd({ "VimEnter" }, {
  group = baseGroup,
  pattern = "*",
  command = "highlight TreesitterContextBottom gui=underline guisp=Grey",
})

-- NOTE: fix for insert bug
autocmd("WinLeave", {
  callback = function()
    if vim.bo.ft == "TelescopePrompt" and vim.fn.mode() == "i" then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "i", false)
    end
  end,
})
-- print("mikemimik.init -- loaded")
