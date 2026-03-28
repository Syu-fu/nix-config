vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local ok = pcall(vim.treesitter.start)
    if ok then
      vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
