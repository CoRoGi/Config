return function(_, opts)
  local notify = require "notify"
  opts["background_colour"] = "#000000"
  opts["level"] = vim.log.levels.OFF
  notify.setup(opts)
  vim.notify = notify
end
