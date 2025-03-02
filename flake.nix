{
  description = "A single configuration file that rules them all.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    agenix.url = "github:ryantm/agenix";

    # Stylix
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop
    niri.url = "github:sodiboo/niri-flake";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nvf.url = "github:notashelf/nvf";
    swts.url = "github:Shyrogan/swts";

    # Applications
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    nixos-hardware,
    nix-gaming,
    nvf,
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
              agenix.homeManagerModules.default
              nvf.homeManagerModules.default
              ./home/sebastien.nix
            ];
          };
        };
      }
    );
}
