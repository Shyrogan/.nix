{ flake, pkgs, ... }:
let
  inherit (flake.inputs) self;
in
{
  environment.systemPackages = [
    pkgs.home-manager
    pkgs.nh
  ];
  home-manager = {
    users.sebastien = self + /configurations/home/sebastien.nix;
    backupFileExtension = "backup";
  };
}
