local status, lspkind = pcall(require, "lspkind")
if (not status) then return end

-- print("after/plugin.lspkind.rc -- loading")
lspkind.init({
  mode = "symbol",
  preset = "default",
  symbol_map = {
    '', -- Text
    '', -- Method
    '', -- Function
    '', -- Constructor
    '', -- Field
    '', -- Variable
    '', -- Class
    'ﰮ', -- Interface
    '', -- Module
    '', -- Property
    '', -- Unit
    '', -- Value
    '', -- Enum
    '', -- Keyword
    '﬌', -- Snippet
    '', -- Color
    '', -- File
    '', -- Reference
    '', -- Folder
    '', -- EnumMember
    '', -- Constant
    '', -- Struct
    '', -- Event
    'ﬦ', -- Operator
    '', -- TypeParameter
  },
})

-- print("after/plugin.lspkind.rc -- loaded")
