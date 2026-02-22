{ pkgs, ... }:
{
  programs.wezterm = {
    enable = true;
    package = pkgs.wezterm;
    extraConfig = ''
      local wezterm = require("wezterm")
      local config = wezterm.config_builder()

      -- Font
      config.font = wezterm.font("HackGenConsole NF")
      config.font_size = 14.0

      -- Color scheme (Gruvbox material dark)
      config.color_scheme = "gruvbox_material_dark_hard"

      -- Window
      config.window_padding = {
        left = 8,
        right = 8,
        top = 8,
        bottom = 8,
      }

      -- Tab bar (managed by tmux)
      config.enable_tab_bar = false

      -- Cursor
      config.default_cursor_style = "BlinkingBar"

      -- Scrollback
      config.scrollback_lines = 10000

      -- macOS SKK input method support
      config.use_ime = true
      config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

      return config
    '';
  };
}
