{
  description = "syu-fu's nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xremap-flake = {
      url = "github:xremap/nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    skk-time-server.url = "github:Syu-fu/skk-time-server";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, xremap-flake, skk-time-server, pre-commit-hooks, neovim-nightly-overlay, ... }:
    let
      darwinSystem = "aarch64-darwin";
      nixosSystem = "x86_64-linux";
      darwinPkgs = import nixpkgs {
        system = darwinSystem;
        overlays = [ neovim-nightly-overlay.overlays.default ];
      };
    in
    {
      # macOS home-manager configuration
      homeConfigurations = {
        darwinConfigurations = home-manager.lib.homeManagerConfiguration {
          pkgs = darwinPkgs;
          modules = [
            ./home-manager/home.nix
          ];
        };
      };

      # NixOS configuration
      nixosConfigurations.ThinkpadX1Carbon = nixpkgs.lib.nixosSystem {
        system = nixosSystem;
        modules = [
          { nixpkgs.overlays = [ neovim-nightly-overlay.overlays.default ]; }
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          xremap-flake.nixosModules.default
          skk-time-server.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              users.syu-fu = import ./home-manager/home.nix;
            };
          }
        ];
      };

      # Formatter
      formatter.${darwinSystem} = darwinPkgs.nixpkgs-fmt;

      # Development shell with pre-commit hooks
      devShells.${darwinSystem}.default = darwinPkgs.mkShell {
        inherit (self.checks.${darwinSystem}.pre-commit-check) shellHook;
        buildInputs = self.checks.${darwinSystem}.pre-commit-check.enabledPackages;
      };

      # Pre-commit checks
      checks.${darwinSystem}.pre-commit-check = pre-commit-hooks.lib.${darwinSystem}.run {
        src = ./.;
        hooks = {
          nixpkgs-fmt.enable = true;
          statix.enable = true;
          deadnix.enable = true;
        };
      };
    };
}
