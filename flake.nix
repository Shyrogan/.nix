{
  description = "A single configuration file that rules them all.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    agenix.url = "github:ryantm/agenix";

    # Stylix
    # TODO: go back to normal stylix once this is merged.
    stylix.url = "github:danth/stylix";

    # Desktop
    niri.url = "github:sodiboo/niri-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    swts.url = "github:Shyrogan/swts";

    # Applications
    nixvim.url = "github:nix-community/nixvim";
    neve.url = "github:redyf/Neve";
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
        inherit (inputs) agenix;
      in {
        nixosConfigurations = {
          mizu = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs outputs;
            };
            modules = [
              agenix.nixosModules.default
              # Common and host-specific config
              ./hosts/common
              ./hosts/mizu
            ];
          };
          hi = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = {
              inherit inputs outputs;
            };
            modules = [
              agenix.nixosModules.default
              # Common and host-specific config
              ./hosts/common
              ./hosts/hi
            ];
          };
        };
        homeConfigurations = {
          home-manager.backupFileExtension = "backup";
          home-manager.useUserPackages = true;
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
