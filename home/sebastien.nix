{ inputs, pkgs, ... }: let
  inherit (inputs) Neve stylix;
in {
  nixpkgs.config.allowUnfree = true;

  imports = [
    stylix.homeManagerModules.stylix
    ./modules
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/irblack.yaml";
    image = ../assets/wallpaper.png;
  };

  home = {
    username = "sebastien";
    homeDirectory = "/home/sebastien";

    packages = with pkgs; [
      # Neovim
      Neve.packages.${pkgs.system}.default 

      graalvm-ce

      jetbrains.idea-ultimate
      vesktop
    ];

    stateVersion = "24.05";
  };

  programs = {
    firefox.enable = true;
    wezterm.enable = true;
    niri.enable = true;
    nushell.enable = true;
    waybar.enable = true;
    fuzzel.enable = true;
  };
}

