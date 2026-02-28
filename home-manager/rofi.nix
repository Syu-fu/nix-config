{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "${pkgs.wezterm}/bin/wezterm";
    theme =
      let
        inherit (pkgs.lib) mkLiteral;
      in
      {
        "*" = {
          bg = mkLiteral "#1d2021";
          bg-alt = mkLiteral "#282828";
          fg = mkLiteral "#d4be98";
          fg-alt = mkLiteral "#a89984";
          accent = mkLiteral "#a9b665";
          urgent = mkLiteral "#ea6962";

          background-color = mkLiteral "@bg";
          text-color = mkLiteral "@fg";
          border-color = mkLiteral "@accent";
        };

        "window" = {
          width = mkLiteral "600px";
          border = mkLiteral "2px";
          border-radius = mkLiteral "8px";
          padding = mkLiteral "12px";
        };

        "inputbar" = {
          padding = mkLiteral "8px 12px";
          background-color = mkLiteral "@bg-alt";
          border-radius = mkLiteral "4px";
          margin = mkLiteral "0 0 8px 0";
        };

        "listview" = {
          lines = 8;
          spacing = mkLiteral "4px";
        };

        "element" = {
          padding = mkLiteral "6px 12px";
          border-radius = mkLiteral "4px";
        };

        "element selected" = {
          background-color = mkLiteral "@accent";
          text-color = mkLiteral "@bg";
        };

        "element-text" = {
          background-color = mkLiteral "transparent";
          text-color = mkLiteral "inherit";
        };
      };
  };
}
