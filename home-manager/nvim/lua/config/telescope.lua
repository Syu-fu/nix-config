local builtin = require("telescope.builtin")

require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<C-u>"] = false,
        ["<C-d>"] = false,
      },
    },
  },
})

local function project_files()
  local ok = pcall(builtin.git_files, { show_untracked = true })
  if not ok then
    builtin.find_files()
  end
end

vim.keymap.set("n", ";b", builtin.buffers, { desc = "Telescope: buffers" })
vim.keymap.set("n", ";p", project_files, { desc = "Telescope: project files" })
vim.keymap.set("n", ";/", builtin.live_grep, { desc = "Telescope: live grep" })
vim.keymap.set("n", ";d", builtin.diagnostics, { desc = "Telescope: diagnostics" })
vim.keymap.set("n", ";h", builtin.help_tags, { desc = "Telescope: help tags" })
