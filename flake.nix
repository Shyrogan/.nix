{
  description = "A single configuration file that rules them all.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    agenix.url = "github:ryantm/agenix";

    # Stylix
    stylix.url = "github:danth/stylix";

    # Desktop
    niri.url = "github:sodiboo/niri-flake";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Applications
    nixvim.url = "github:nix-community/nixvim";
    neve.url = "github:Redyf/Neve";
    nix-gaming.url = "github:fufexan/nix-gaming";
    fenix.url = "github:nix-community/fenix";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    nixos-hardware,
    nix-gaming,
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
              nixos-hardware.nixosModules.common-cpu-amd
              nixos-hardware.nixosModules.common-gpu-amd
              nixos-hardware.nixosModules.common-pc-laptop-ssd
              nix-gaming.nixosModules.platformOptimizations
              # Common and host-specific config
              ./hosts/common
              ./hosts/mizu
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
