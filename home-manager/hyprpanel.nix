{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.isLinux {
  home.activation.hyprpanelConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config_dir="$HOME/.config/hyprpanel"
    config_file="$config_dir/config.json"
    mkdir -p "$config_dir"
    if [ ! -f "$config_file" ]; then
      echo '{}' > "$config_file"
    fi
    tmp=$(${pkgs.jq}/bin/jq \
      '.bar.launcher.icon = "" | .bar.launcher.autoDetectIcon = false' \
      "$config_file")
    echo "$tmp" > "$config_file"
  '';
}
