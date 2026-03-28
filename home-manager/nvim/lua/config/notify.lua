local notify = require("notify")

---@type notify.Config
local opts = {
  background_colour = "#1d2021",
  stages = "fade_in_slide_out",
  timeout = 3000,
  max_width = 60,
  icons = {
    ERROR = "",
    WARN  = "",
    INFO  = "",
    DEBUG = "",
    TRACE = "✎",
  },
}

notify.setup(opts)

vim.notify = notify
