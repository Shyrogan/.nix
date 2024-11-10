{
  description = "A single configuration file that rules them all.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";

    # Stylix
    stylix.url = "github:danth/stylix";

    # Desktop
    niri.url = "github:sodiboo/niri-flake";

    # Applications
    Neve.url = "github:redyf/Neve";
    wezterm.url = "github:wez/wezterm?dir=nix";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystemPassThrough (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (self) outputs;
      in {
        nixosConfigurations = {
          mizu = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs outputs;
            };
            modules = [
              # Common and host-specific config
              ./hosts/common
              ./hosts/mizu

              # Desktop environment
              ./hosts/common/desktops/niri.nix
            ];
          };
        };
        homeConfigurations = {
          home-manager.backupFileExtension = "backup";
          sebastien = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            extraSpecialArgs = {
              inherit inputs outputs;
            };

            modules = [
              ./home/sebastien.nix
            ];
          };
        };
      }
    );
}
