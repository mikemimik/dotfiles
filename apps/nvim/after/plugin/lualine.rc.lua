local status, lualine = pcall(require, "lualine")
if (not status) then return end

print("after/plugin.lualine.rc -- loading")

lualine.setup({
  options = {
    icons_enabled = true,
    theme = "wombat",
    component_separators = "",
    section_separators = "",
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { "mode" },
    -- TODO: remove when using tmux; this information will be in tmux status
    lualine_b = { "branch" },
    lualine_c = { {
      "filename",
      file_status = true, -- display file status (readonly, modified)
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
      symbols = {
        modified = "[+]",
        readonly = "[-]",
        unnamed = "[No Name]",
        newfile = "[New]",
      },
    } },
    lualine_x = {
      {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn", "info", "hint" },
        symbols = {
          error = "📛 ",
          warn = "⚠️  ",
          info = "ℹ️  ",
          hint = "💡",
        },
        colored = true,
        update_in_insert = true,
        always_visible = true,
      },
      { "filetype" }
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

print("after/plugin.lualine.rc -- loaded")
