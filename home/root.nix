{ inputs, pkgs, ... }: let
  inherit (inputs) stylix;
in {
  nixpkgs.config.allowUnfree = true;

  imports = [
    stylix.homeManagerModules.stylix
    ./modules
  ];

  # Styling
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = ../assets/dark-wallpaper.png;
    polarity = "dark";
  };

  # User info
  home = {
    username = "root";
    homeDirectory = "/root";

    packages = with pkgs; [ dconf ];

    stateVersion = "24.05";
  };

  # Programs
  programs = {
    nushell.enable = true;
    nixvim.enable = true;
  };
}

