return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<c-f>",
        LazyVim.pick("live_grep", { root = false }),
        desc = "Search with Grep",
      },
      {
        "<c-p>",
        LazyVim.pick("files", { root = false }),
        desc = "Search with Filenames",
      },
    },
  },
}
