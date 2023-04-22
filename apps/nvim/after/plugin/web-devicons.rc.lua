local status, icons = pcall(require, "nvim-web-devicons")
if (not status) then return end

-- print("after/plugin.web-devicons.rc -- loading")
icons.setup({
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
  color_icons = true,
})

-- print("after/plugin.web-devicons.rc -- loaded")
