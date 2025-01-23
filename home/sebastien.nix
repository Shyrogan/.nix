{ inputs, pkgs, ... }: let
  inherit (inputs) nix-gaming stylix;
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
    fonts.monospace = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
  };

  # User info
  home = {
    username = "sebastien";
    homeDirectory = "/home/sebastien";

    packages = with pkgs; [
      graalvm-ce
      vesktop

      gtk3
      gdk-pixbuf

      thunderbird
      slack
      obs-studio

      gitkraken

      zotero
      onlyoffice-bin

      # DevOps tools
      k3s
      argocd
      kubernetes-helm
      vlc

      nix-gaming.packages.${pkgs.hostPlatform.system}.rocket-league
    ];

    stateVersion = "24.05";
  };

  # Programs
  programs = {
    ankama-launcher.enable = true;
    firefox.enable = true;
    nushell.enable = true;
    fuzzel.enable = true;
    nixvim.enable = true;
    zathura.enable = true;
    zellij.enable = true;
    ghostty.enable = true;
  };

  programming = {
    rust.enable = true;
    web.enable = true;
  };

  services = {
    ollama.enable = true;
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

