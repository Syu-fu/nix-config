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
      { plugin = plenary-nvim; optional = true; }
      { plugin = telescope-nvim; optional = true; }
      { plugin = telescope-fzf-native-nvim; optional = true; }
      { plugin = lualine-nvim; optional = true; }
      { plugin = nvim-notify; optional = true; }
      { plugin = gitsigns-nvim; optional = true; }
      { plugin = oil-nvim; optional = true; }
      { plugin = quicker-nvim; optional = true; }
      { plugin = nvim-bqf; optional = true; }
      {
        plugin = pkgs.vimPlugins.nvim-treesitter.withPlugins (p: with p; [
          bash
          json
          lua
          markdown
          markdown_inline
          nix
          query
          regex
          toml
          vim
          vimdoc
          yaml
        ]);
        optional = true;
      }
    ];

    extraPackages = with pkgs; [
      lua-language-server
      nixd
      ripgrep
      fd
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua/config/plugins.lua".source = ./nvim/lua/config/plugins.lua;
    "nvim/lua/config/completion.lua".source = ./nvim/lua/config/completion.lua;
    "nvim/lua/config/colors.lua".source = ./nvim/lua/config/colors.lua;
    "nvim/lua/config/options.lua".source = ./nvim/lua/config/options.lua;
    "nvim/lua/config/lsp.lua".source = ./nvim/lua/config/lsp.lua;
    "nvim/lua/config/telescope.lua".source = ./nvim/lua/config/telescope.lua;
    "nvim/lua/config/lualine.lua".source = ./nvim/lua/config/lualine.lua;
    "nvim/lua/config/notify.lua".source = ./nvim/lua/config/notify.lua;
    "nvim/lua/config/gitsigns.lua".source = ./nvim/lua/config/gitsigns.lua;
    "nvim/lua/config/oil.lua".source = ./nvim/lua/config/oil.lua;
    "nvim/lua/config/quicker.lua".source = ./nvim/lua/config/quicker.lua;
    "nvim/lua/config/bqf.lua".source = ./nvim/lua/config/bqf.lua;
    "nvim/lua/config/treesitter.lua".source = ./nvim/lua/config/treesitter.lua;
  };
}
