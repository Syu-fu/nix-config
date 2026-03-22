local ok, lspconfig = pcall(require, "lspconfig")

if not ok then
  vim.notify("nvim-lspconfig is not available", vim.log.levels.ERROR)
  return
end

local lua_ls_config = {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

if vim.lsp.config ~= nil and vim.lsp.enable ~= nil then
  vim.lsp.config("lua_ls", lua_ls_config)
  vim.lsp.enable("lua_ls")
  return
end

lspconfig.lua_ls.setup(lua_ls_config)
