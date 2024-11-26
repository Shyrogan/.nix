{ inputs, pkgs, ... }: let
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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
    image = ../assets/dark-wallpaper.png;
    polarity = "dark";
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

      thunderbird
      slack
      obs-studio
    ];

    stateVersion = "24.05";
  };

  # Programs
  programs = {
    ankama-launcher.enable = true;
    firefox.enable = true;
    wezterm.enable = true;
    nushell.enable = true;
    swts.bar = {
      enable = true;
      hyprland.enable = true;
    };
    fuzzel.enable = true;
    nixvim.enable = true;
    zathura.enable = true;
    #pharo.enable = true;
  };
  xdg.mime = {
    enable = true;
  };
  wayland.windowManager.hyprland.enable = true;
}

