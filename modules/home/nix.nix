{ config, lib, flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) determinate;
in
{
  nix.package = lib.mkDefault determinate.packages.${pkgs.system}.default;
  home.packages = [
    config.nix.package
  ];
}
