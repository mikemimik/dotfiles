local status, telescope = pcall(require, "telescope")
if (not status) then return end

-- print("after/plugin.telescope.rc -- loading")
local nnoremap = require("mikemimik.keymap").nnoremap

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")
local config = require("telescope.config")

local grep_args = { unpack(config.values.vimgrep_arguments) }
table.insert(grep_args, "--hidden")
table.insert(grep_args, "--glob")
table.insert(grep_args, "!.git/*")

telescope.setup({
  defaults = {
    prompt_prefix = " > ",
    layout_strategy = "vertical",
    layout_config = {
      height = 0.7,
    },
    mappings = {
      n = {
        ["q"] = actions.close,
      },
      i = {
        ["<esc>"] = actions.close,
        ["<leader>,"] = actions.close,
        ["<leader>v"] = actions.select_vertical,
        ["<leader>x"] = actions.select_horizontal,
        ["<leader>t"] = actions.select_tab,
        ["<S-Down>"] = actions.preview_scrolling_down,
        ["<S-Up>"] = actions.preview_scrolling_up,
        ["<S-Left>"] = actions.preview_scrolling_left,
        ["<S-Right>"] = actions.preview_scrolling_right,
        ["<Left>"] = actions.results_scrolling_left,
        ["<Right>"] = actions.results_scrolling_right,
      },
    },
    vimgrep_arguments = grep_args,
  },
  pickers = {
    find_files = {
      find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      hijack_netrw = true,
      mappings = {
        ["i"] = {
        },
        ["n"] = {
          ["<leader>v"] = actions.select_vertical,
          ["<leader>x"] = actions.select_horizontal,
          ["<leader>t"] = actions.select_tab,
        },
      },
    },
  },
})

telescope.load_extension("file_browser")

local function telescope_buffer_dir()
  return vim.fn.expand('%:p:h')
end

nnoremap("<c-p>", function()
  builtin.find_files({
    prompt_prefix = "Files > ",
    attach_mappings = function(_, map)
      -- These are set above in the defaults; leaving them here are a reminder
      -- of how to do this.
      -- map("i", "<leader>v", actions.select_vertical)
      -- map("i", "<leader>x", actions.select_horizontal)

      return true;
    end,
  })
end)

nnoremap("<c-f>", function()
  builtin.live_grep({
    prompt_prefix = "Grep > ",
    attach_mappings = function(_, map)
      -- map("i", "<leader>v", actions.select_vertical)
      -- map("i", "<leader>x", actions.select_horizontal)

      return true;
    end,
  })
end)

nnoremap("\\\\", function()
  builtin.buffers({
    ignore_current_buffer = true,
    sort_mru = true,
  })
end)

nnoremap("<leader>z", function()
  builtin.diagnostics({
    layout_strategy = "vertical",
  })
end)

nnoremap("<leader>e", function()
  telescope.extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
    -- prompt_title = false,
  })
end)

-- print("after/plugin.telescope.rc -- loaded")
