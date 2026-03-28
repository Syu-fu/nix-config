{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.isLinux {
  home.activation.hyprpanelConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    config_dir="$HOME/.config/hyprpanel"
    config_file="$config_dir/config.json"
    mkdir -p "$config_dir"
    if [ ! -f "$config_file" ]; then
      printf '{}' > "$config_file"
    fi
    nix_icon=$(printf '\xef\x8c\x93')
    tmp=$(mktemp)
    if ${pkgs.jq}/bin/jq --arg icon "$nix_icon" \
      '.bar.launcher.icon = $icon
        | .bar.launcher.autoDetectIcon = false
        | if .bar.layouts then
            .bar.layouts |= with_entries(
              .value.left = (["dashboard"] + (.value.left // [] | map(select(. != "dashboard"))))
            )
          else . end' \
      "$config_file" > "$tmp"; then
      mv "$tmp" "$config_file"
    else
      rm -f "$tmp"
    fi
  '';
}
