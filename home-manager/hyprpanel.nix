{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.isLinux {
  xdg.configFile."hyprpanel/config.json".text = builtins.toJSON {
    bar = {
      launcher = {
        icon = "";
        autoDetectIcon = false;
      };
    };
  };
}
