{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self zen-browser;
in {
  imports = [
    self.homeModules.default
  ];

  me = {
    username = "sebastien";
    fullname = "Sébastien VIAL";
    email = "sebastien@shyrogan.fr";
  };

  programs = {
    nushell.enable = true;
    ghostty.enable = true;
    fuzzel.enable = true;
    nvf.enable = true;
    vesktop.enable = true;
    obs-studio.enable = true;
    spicetify.enable = true;
    ankama-launcher.enable = true;
    hyprshot.enable = true;
    walker.enable = true;
    tmux.enable = true;
    opencode.enable = true;
  };
  services = {
    hyprpaper.enable = true;
  };
  wayland.windowManager.hyprland.enable = true;
  home.packages = with pkgs; [
    pavucontrol
    vlc
    nautilus
    lazygit
    gimp
    slack
    devenv
    thunderbird
    wootility
    kubectl
    kubernetes-helm
    brave
    inter
    watchexec
  ];

  home.stateVersion = "25.05";
}
