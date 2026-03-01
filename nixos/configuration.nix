{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Hostname
  networking = {
    hostName = "ThinkpadX1Carbon";
    networkmanager.enable = true;
  };

  # Timezone and locale
  time.timeZone = "Asia/Tokyo";
  i18n = {
    defaultLocale = "ja_JP.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "ja_JP.UTF-8";
      LC_IDENTIFICATION = "ja_JP.UTF-8";
      LC_MEASUREMENT = "ja_JP.UTF-8";
      LC_MONETARY = "ja_JP.UTF-8";
      LC_NAME = "ja_JP.UTF-8";
      LC_NUMERIC = "ja_JP.UTF-8";
      LC_PAPER = "ja_JP.UTF-8";
      LC_TELEPHONE = "ja_JP.UTF-8";
      LC_TIME = "ja_JP.UTF-8";
    };
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-skk
        fcitx5-gtk
      ];
    };
  };

  # Intel graphics
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # Display manager / Sound / xremap
  services = {
    greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xremap = {
      enable = true;
      userName = "syu-fu";
      config = {
        modmap = [
          {
            name = "CapsLock to Ctrl (built-in keyboard only)";
            device.only = [ "AT Translated Set 2 keyboard" ];
            remap = {
              CapsLock = "Ctrl_L";
            };
          }
          {
            name = "SandS";
            remap = {
              Space = {
                held = "Shift_L";
                alone = "Space";
                alone_timeout_millis = 200;
              };
            };
          }
        ];
      };
    };
  };

  # Shells / Wayland / Hyprland / 1Password
  programs = {
    zsh.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "syu-fu" ];
    };
  };

  # XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # User
  users.users.syu-fu = {
    isNormalUser = true;
    description = "Syu-fu";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" ];
    shell = pkgs.zsh;
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      hackgen-nf-font
    ];
    fontconfig.defaultFonts = {
      sansSerif = [ "Noto Sans CJK JP" ];
      serif = [ "Noto Serif CJK JP" ];
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
  ];

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}
