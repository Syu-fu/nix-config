{ pkgs, ... }:
let
  gruvboxMaterial = pkgs.vimPlugins."gruvbox-material" or pkgs.vimPlugins."vim-gruvbox-material";
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      { plugin = nvim-lspconfig; optional = true; }
      { plugin = gruvboxMaterial; optional = true; }
      { plugin = blink-cmp; optional = true; }
    ];

    extraPackages = with pkgs; [
      lua-language-server
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua/config/plugins.lua".source = ./nvim/lua/config/plugins.lua;
    "nvim/lua/config/completion.lua".source = ./nvim/lua/config/completion.lua;
    "nvim/lua/config/colors.lua".source = ./nvim/lua/config/colors.lua;
    "nvim/lua/config/options.lua".source = ./nvim/lua/config/options.lua;
    "nvim/lua/config/lsp.lua".source = ./nvim/lua/config/lsp.lua;
  };
}
