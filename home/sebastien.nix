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
    base16Scheme = ../assets/config/gruvbox-dark-hard-base16.yml;
    image = ../assets/wallpaper_loris.png;
    polarity = "dark";
  };

  # User info
  home = {
    username = "sebastien";
    homeDirectory = "/home/sebastien";

    packages = with pkgs; [
      graalvm-ce

      jetbrains.idea-ultimate
      eclipses.eclipse-modeling
      vesktop

      gtk3
      gdk-pixbuf

      thunderbird
      slack
      obs-studio

      gitkraken

      # DevOps tools
      k3s
      argocd
      kubernetes-helm
      vlc

      # Desktop stuff
      libreoffice-qt
      hunspell
      hunspellDicts.fr-moderne
      hunspellDicts.en_US
      zotero
    ];

    stateVersion = "24.05";
  };

  # Programs
  programs = {
    ankama-launcher.enable = true;
    firefox.enable = true;
    #wezterm.enable = true;
    nushell.enable = true;
    fuzzel.enable = true;
    nixvim.enable = true;
    zathura.enable = true;
    #pharo.enable = true;
    zellij.enable = true;
    ghostty.enable = true;
  };
  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["zathura.desktop"];
        "x-scheme-handler/http" = ["firefox.desktop"];
        "x-scheme-handler/https" = ["firefox.desktop"];
        "text/html" = ["firefox.desktop"];
      };
    };
  };
  wayland.windowManager.hyprland.enable = true;
}

