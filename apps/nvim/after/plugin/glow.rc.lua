local log = require("mikemimik.log").new({ plugin = "glow" })

local status, glow = pcall(require, "glow")
if (not status) then
  log.error("after/plugin.glow.rc -- error")
  return
end

glow.setup({
  width_ratio = 0.7,
})
