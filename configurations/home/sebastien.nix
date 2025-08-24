{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
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
    niri.enable = true;
    nushell.enable = true;
    ghostty.enable = true;
    fuzzel.enable = true;
  };

  home.stateVersion = "25.05";
}
