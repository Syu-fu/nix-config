{ pkgs, ... }:
let
  vimium = pkgs.fetchFirefoxAddon {
    name = "vimium";
    url = "https://addons.mozilla.org/firefox/downloads/file/4618554/vimium_ff-2.3.1.xpi";
    hash = "sha256-0wqlb4iik74h1jilkif20zl6br3l3rfvjq2fdsic4f8rnhf8c6rc=";
  };
in
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      extensions.packages = [ vimium ];
    };
  };

  home.packages = pkgs.lib.optionals (!pkgs.stdenv.isDarwin) [
    pkgs.chromium
  ];
}
