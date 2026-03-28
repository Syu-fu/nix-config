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
    default_layouts='{"0":{"left":["dashboard","workspaces","windowtitle"],"middle":["media"],"right":["volume","network","bluetooth","battery","systray","clock","notifications"]},"1":{"left":["dashboard","workspaces","windowtitle"],"middle":["media"],"right":["volume","clock","notifications"]},"2":{"left":["dashboard","workspaces","windowtitle"],"middle":["media"],"right":["volume","clock","notifications"]}}'
    tmp=$(mktemp)
    if ${pkgs.jq}/bin/jq --arg icon "$nix_icon" --argjson defaults "$default_layouts" \
      '. as $cur
        | .bar.launcher.icon = $icon
        | .bar.launcher.autoDetectIcon = false
        | .scalingPriority = "hyprland"
        | .bar.layouts = (
            $defaults | with_entries(
              .key as $k |
              .value.left = (
                ["dashboard"] + (
                  ($cur.bar.layouts[$k].left // .value.left)
                  | map(select(. != "dashboard"))
                )
              )
            )
          )' \
      "$config_file" > "$tmp"; then
      mv "$tmp" "$config_file"
    else
      rm -f "$tmp"
    fi
  '';
}
