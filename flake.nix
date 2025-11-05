{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-linux-kernel.url = "github:nixos/nixpkgs/17f6bd177404d6d43017595c5264756764444ab8";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    agenix.url = "github:ryantm/agenix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-unified.url = "github:srid/nixos-unified";

    stylix.url = "github:nix-community/stylix";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nvf.url = "github:Shyrogan/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
    fff.url = "github:dmtrKovalenko/fff.nvim";
    fff.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    walker.url = "github:abenz1267/walker";

    swts.url = "github:Shyrogan/swts";

    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs:
    inputs.nixos-unified.lib.mkFlake {
      inherit inputs;
      root = ./.;
    };
}
