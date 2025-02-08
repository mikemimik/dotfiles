return {
  {
    "ibhagwan/fzf-lua",
    keys = {
      {
        "<c-f>",
        LazyVim.pick("live_grep", { root = false }),
        desc = "Search with Grep",
      },
    },
  },
}
