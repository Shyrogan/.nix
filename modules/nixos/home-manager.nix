{ flake, ...}: 
let
  inherit (flake) home-manager;
in
{
  imports = [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.users.sebastien = ../../configurations/home/sebastien.nix;
    }
  ];
}
