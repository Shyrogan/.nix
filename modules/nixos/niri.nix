{ flake, pkgs, ... }:
let
  inherit (flake.inputs) niri;
in
{
  imports = [
    niri.nixosModules.niri
  ];
  nixpkgs.overlays = [ niri.overlays.niri ];
  programs.niri.package = pkgs.niri-unstable;
}
