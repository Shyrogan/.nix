{flake, ...}: let
  inherit (flake.inputs) walker;
in {
  imports = [
    walker.homeManagerModules.default
  ];
  programs.walker = {
    runAsService = true;
  };
}
