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
    separator_style = "slant",
    -- separator_style = "thin",
    show_close_icon = false,
    buffer_close_icon = "",
    close_icon = "",
    color_icons = false,
    -- left_trunc_marker = "",
    -- right_trunc_marker = "",
    -- indicator = {
    --   icon = "| ",
    --   style = "none",
    -- },
    numbers = "buffer_id",
  },
})

log.debug("after/plugin.bufferline.rc -- loaded")
