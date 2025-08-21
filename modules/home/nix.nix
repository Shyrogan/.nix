{ config, lib, flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) determinate;
in
{
  nix.package = lib.mkDefault determinate.packages.default;
  home.packages = [
    config.nix.package
  ];
}
