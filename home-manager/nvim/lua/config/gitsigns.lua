require("gitsigns").setup({
  signs = {
    add          = { text = "▎" },
    change       = { text = "▎" },
    delete       = { text = "" },
    topdelete    = { text = "" },
    changedelete = { text = "▎" },
    untracked    = { text = "▎" },
  },
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local map = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "]h", function() gs.nav_hunk("next") end, "Gitsigns: next hunk")
    map("n", "[h", function() gs.nav_hunk("prev") end, "Gitsigns: prev hunk")
    map("n", "<leader>hs", gs.stage_hunk,                "Gitsigns: stage hunk")
    map("n", "<leader>hr", gs.reset_hunk,                "Gitsigns: reset hunk")
    map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Gitsigns: stage hunk")
    map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Gitsigns: reset hunk")
    map("n", "<leader>hS", gs.stage_buffer,              "Gitsigns: stage buffer")
    map("n", "<leader>hR", gs.reset_buffer,              "Gitsigns: reset buffer")
    map("n", "<leader>hp", gs.preview_hunk,              "Gitsigns: preview hunk")
    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Gitsigns: blame line")
    map("n", "<leader>hd", gs.diffthis,                  "Gitsigns: diff this")
  end,
})
