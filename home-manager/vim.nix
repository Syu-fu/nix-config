{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];

    extraPackages = with pkgs; [
      lua-language-server
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua/config/options.lua".source = ./nvim/lua/config/options.lua;
    "nvim/lua/config/lsp.lua".source = ./nvim/lua/config/lsp.lua;
  };
}
