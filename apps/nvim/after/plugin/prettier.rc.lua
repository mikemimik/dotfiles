local status, prettier = pcall(require, "prettier")
if (not status) then return end

-- print("after/plugin.prettier.rc -- loading")
prettier.setup({
  bin = "prettierd",
  filtypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "yaml",
  },
  -- ["null-ls"] = {
  --   runtime_condition = function(param)
  --     return true
  --   end,
  -- },
})

-- print("after/plugin.prettier.rc -- loaded")
