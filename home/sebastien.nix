{ inputs, pkgs, ... }: let
  inherit (inputs) neve stylix;
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
    iconTheme = rec {
      enable = true;
      package = pkgs.morewaita-icon-theme;
      light = "MoreWaita";
      dark = light;
    };
  };

  home = {
    username = "sebastien";
    homeDirectory = "/home/sebastien";

    packages = with pkgs; [
      # Neovim
      neve.packages.${pkgs.system}.default 

      graalvm-ce

      jetbrains.idea-ultimate
      vesktop

      gtk3
      gdk-pixbuf
    ];

    stateVersion = "24.05";
  };

  programs = {
    firefox.enable = true;
    wezterm.enable = true;
    #niri.enable = true;
    nushell.enable = true;
    swts.desktop.enable = true;
    fuzzel.enable = true;
  };
  xdg.mime = {
    enable = true;
  };
  wayland.windowManager.hyprland.enable = true;
}

