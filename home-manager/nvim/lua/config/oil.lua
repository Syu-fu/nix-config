---@type oil.SetupOpts
local opts = {
  default_file_explorer = true,
  delete_to_trash = true,
  view_options = {
    show_hidden = true,
  },
  float = {
    padding = 2,
    max_width = 80,
    max_height = 30,
  },
}

require("oil").setup(opts)
