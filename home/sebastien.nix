{ inputs, pkgs, lib, ... }: let
  inherit (inputs) stylix nixvim;
in {
  nixpkgs.config.allowUnfree = true;

  imports = [
    stylix.homeManagerModules.stylix
    ./modules
  ];

  # Styling
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/irblack.yaml";
    image = ../assets/wallpaper.png;
    iconTheme = rec {
      enable = true;
      package = pkgs.morewaita-icon-theme;
      light = "MoreWaita";
      dark = light;
    };
  };

  # User info
  home = {
    username = "sebastien";
    homeDirectory = "/home/sebastien";

    packages = with pkgs; [
      graalvm-ce

      jetbrains.idea-ultimate
      vesktop

      gtk3
      gdk-pixbuf
    ];

    stateVersion = "24.05";
  };

  # Programs
  programs = {
    firefox.enable = true;
    wezterm.enable = true;
    nushell.enable = true;
    swts.desktop.enable = true;
    fuzzel.enable = true;
    nixvim.enable = true;
    zathura.enable = true;
  };
  xdg.mime = {
    enable = true;
  };
  wayland.windowManager.hyprland.enable = true;
}

