{
  description = "syu-fu's nix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, pre-commit-hooks, ... }:
    let
      darwinSystem = "aarch64-darwin";
      nixosSystem = "x86_64-linux";
      darwinPkgs = nixpkgs.legacyPackages.${darwinSystem};
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
      nixosConfigurations.Syu-fu = nixpkgs.lib.nixosSystem {
        system = nixosSystem;
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
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
