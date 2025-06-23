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
    base16Scheme = "${pkgs.base16-schemes}/share/themes/one-light.yaml";
    image = ../assets/everforest/fog_forest_alt_2.png;
    polarity = "light";
    fonts.monospace = {
      name = "JetBrainsMono Nerd Font";
      package = pkgs.nerd-fonts.jetbrains-mono;
    };
    cursor = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
      size = 24;
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
      sshfs

      prismlauncher
      zen-browser.packages.${pkgs.system}.default
      lazygit

      jetbrains.datagrip

      code-cursor

      gnome-font-viewer

      element-desktop
    ];

    stateVersion = "24.05";
  };

  services = {
    podman.enable = true;
    ollama.enable = true;
  };

  # Programs
  programs = {
    nushell.enable = true;
    fuzzel.enable = true;
    zathura.enable = true;
    zellij.enable = true;
    ghostty.enable = true;
    nvf.enable = true;
    spicetify.enable = true;
    helix.enable = true;
    mergiraf.enable = true;
    git = {
      enable = true;
      difftastic = {
        enable = true;
        enableAsDifftool = true;
      };
    };
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
