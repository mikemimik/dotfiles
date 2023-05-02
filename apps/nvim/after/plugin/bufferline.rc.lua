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
    indicator = {
      style = "underline",
    },
    diagnostics = "nvim_lsp",
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = false,
    show_close_icon = false,
    persist_buffer_sort = false,
    separator_style = { "|", "|" },
  },
})

log.debug("after/plugin.bufferline.rc -- loaded")
