{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self zen-browser;
in
{
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
  };
  home.packages = [
    zen-browser.packages.${pkgs.system}.default
    pkgs.pavucontrol
    pkgs.vlc
    pkgs.nautilus
    pkgs.lazygit
  ];

  home.stateVersion = "25.05";
}
