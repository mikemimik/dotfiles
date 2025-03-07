return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "muniftanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    opts = {
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
        },
      },
      window = {
        mappings = {
          ["<leader>v"] = "open_vsplit",
          ["<leader>x"] = "open_split",
          -- INFO: same mappings used with telescope
          ["<C-u>"] = "open_vsplit",
          ["<C-i>"] = "open_split",
        },
      },
    },
    keys = {
      {
        "<leader>E",
        function()
          require("neo-tree.command").execute({
            action = "focus",
            source = "filesystem",
            toggle = true,
            dir = vim.uv.cwd(),
            reveal = true,
          })
        end,
        desc = "Explorer NeoTree (Root Dir)",
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            action = "focus",
            source = "filesystem",
          })
        end,
        desc = "Explorer NeoTree (focus)",
      },
    },
  },
}
