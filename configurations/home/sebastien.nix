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
    bash.enable = true;
    niri.enable = true;
    nushell.enable = true;
    ghostty.enable = true;
    fuzzel.enable = true;
    nvf.enable = true;
  };
  home.packages = [
    zen-browser.packages.${pkgs.system}.default
  ];

  home.stateVersion = "25.05";
}
