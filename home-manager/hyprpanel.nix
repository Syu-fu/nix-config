{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.isLinux {
  programs.hyprpanel = {
    enable = true;
    package = pkgs.hyprpanel;
    settings = {
      scalingPriority = "hyprland";
      bar = {
        launcher = {
          icon = "";
          autoDetectIcon = false;
        };
        layouts = {
          "*" = {
            left = [ "dashboard" "workspaces" "windowtitle" ];
            middle = [ "media" ];
            right = [ "volume" "network" "bluetooth" "battery" "systray" "clock" "notifications" ];
          };
        };
      };
    };
  };
}
