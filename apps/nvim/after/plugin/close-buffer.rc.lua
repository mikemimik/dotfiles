local log = require("mikemimik.log").new({ plugin = "close-buffer" })

local status, closebuffer = pcall(require, "close_buffers")
if (not status) then
  log.error("after/plugin.close-buffer.rc -- error")
  return
end

log.debug("after/plugin.close-buffer.rc -- loading")
local nnoremap = require("mikemimik.keymap").nnoremap

closebuffer.setup({
  filetype_ignore = {},
  file_glob_ignore ={},
  file_regex_ignore = {},
  preserve_window_layout = { "this", "nameless" },
  next_buffer_cmd = nil,
})

local opts = { noremap = true, silent = true }
nnoremap("<leader>ch", function()
  closebuffer.delete({ type = "hidden" })
end, opts)

nnoremap("<leader>cn", function()
  closebuffer.delete({ type = "nameless" })
end, opts)

nnoremap("<leader>c,", function()
  closebuffer.delete({ type = "this" })
end, opts)

log.debug("after/plugin.close-buffer.rc -- loaded")
