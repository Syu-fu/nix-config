local ok, lspconfig = pcall(require, "lspconfig")

if not ok then
  vim.notify("nvim-lspconfig is not available", vim.log.levels.ERROR)
  return
end

local capabilities = require("blink.cmp").get_lsp_capabilities()

local servers = {
  lua_ls = {
    capabilities = capabilities,
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
  },
  nixd = {
    capabilities = capabilities,
  },
}

if vim.lsp.config ~= nil and vim.lsp.enable ~= nil then
  for server, config in pairs(servers) do
    vim.lsp.config(server, config)
  end
  vim.lsp.enable(vim.tbl_keys(servers))
  return
end

for server, config in pairs(servers) do
  lspconfig[server].setup(config)
end
