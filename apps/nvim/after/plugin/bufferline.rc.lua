local log = require("mikemimik.log").new({ plugin = "bufferline" })

local status, bufferline = pcall(require, "bufferline")
if (not status) then
  log.error("after/plugin.bufferline.rc -- error")
  return
end

log.debug("after/plugin.bufferline.rc -- loading")
bufferline.setup({
  options = {
    mode = "buffers",
    numbers = "buffer_id",
    separator_style = "slant",
    -- separator_style = "thin",
    diagnostics = "nvim_lsp",
    show_close_icon = false,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    color_icons = true,
    -- left_trunc_marker = "",
    -- right_trunc_marker = "",
    -- indicator = {
    --   icon = "| ",
    --   style = "none",
    -- },
    persist_buffer_sort = false,
  },
})

log.debug("after/plugin.bufferline.rc -- loaded")
