{
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) stylix zen-browser;
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
    targets.nvf.enable = false;
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
      sshfs

      prismlauncher
      zen-browser.packages.${pkgs.system}.default
      lazygit

      jetbrains.datagrip

      uxplay
    ];

    stateVersion = "24.05";
  };

  # Programs
  programs = {
    nushell.enable = true;
    fuzzel.enable = true;
    zathura.enable = true;
    zellij.enable = true;
    ghostty.enable = true;
    nvf.enable = true;
  };

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "application/pdf" = ["zathura.desktop"];
        "x-scheme-handler/http" = ["zen-browser.desktop"];
        "x-scheme-handler/https" = ["zen-browser.desktop"];
        "text/html" = ["zen-browser.desktop"];
      };
    };
  };
  wayland.windowManager.hyprland.enable = true;
}
