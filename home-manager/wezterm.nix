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

      -- Color scheme (Gruvbox material dark hard)
      config.colors = {
        foreground = "#d4be98",
        background = "#1d2021",
        cursor_bg = "#d4be98",
        cursor_fg = "#1d2021",
        cursor_border = "#d4be98",
        selection_fg = "#1d2021",
        selection_bg = "#d4be98",
        ansi = {
          "#1d2021", -- black
          "#ea6962", -- red
          "#a9b665", -- green
          "#d8a657", -- yellow
          "#7daea3", -- blue
          "#d3869b", -- magenta
          "#89b482", -- cyan
          "#d4be98", -- white
        },
        brights = {
          "#3c3836", -- bright black
          "#ea6962", -- bright red
          "#a9b665", -- bright green
          "#d8a657", -- bright yellow
          "#7daea3", -- bright blue
          "#d3869b", -- bright magenta
          "#89b482", -- bright cyan
          "#d4be98", -- bright white
        },
      }

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

      -- macOS: remap Cmd key to Meta for tmux bindings
      config.keys = {
        { key = "H", mods = "CMD", action = wezterm.action.SendKey { key = "H", mods = "META" } },
        { key = "J", mods = "CMD", action = wezterm.action.SendKey { key = "J", mods = "META" } },
        { key = "K", mods = "CMD", action = wezterm.action.SendKey { key = "K", mods = "META" } },
        { key = "L", mods = "CMD", action = wezterm.action.SendKey { key = "L", mods = "META" } },
        { key = "h", mods = "CMD", action = wezterm.action.SendKey { key = "h", mods = "META" } },
        { key = "j", mods = "CMD", action = wezterm.action.SendKey { key = "j", mods = "META" } },
        { key = "k", mods = "CMD", action = wezterm.action.SendKey { key = "k", mods = "META" } },
        { key = "l", mods = "CMD", action = wezterm.action.SendKey { key = "l", mods = "META" } },
        { key = "\\", mods = "CMD", action = wezterm.action.SendKey { key = "\\", mods = "META" } },
        { key = "-", mods = "CMD", action = wezterm.action.SendKey { key = "-", mods = "META" } },
        { key = "1", mods = "CMD", action = wezterm.action.SendKey { key = "1", mods = "META" } },
        { key = "2", mods = "CMD", action = wezterm.action.SendKey { key = "2", mods = "META" } },
        { key = "3", mods = "CMD", action = wezterm.action.SendKey { key = "3", mods = "META" } },
        { key = "4", mods = "CMD", action = wezterm.action.SendKey { key = "4", mods = "META" } },
        { key = "5", mods = "CMD", action = wezterm.action.SendKey { key = "5", mods = "META" } },
        { key = "6", mods = "CMD", action = wezterm.action.SendKey { key = "6", mods = "META" } },
        { key = "7", mods = "CMD", action = wezterm.action.SendKey { key = "7", mods = "META" } },
        { key = "8", mods = "CMD", action = wezterm.action.SendKey { key = "8", mods = "META" } },
        { key = "9", mods = "CMD", action = wezterm.action.SendKey { key = "9", mods = "META" } },
      }

      return config
    '';
  };
}
