{ flake, ... }:
let
  inherit (flake.inputs) niri;
in
{
  imports = [
    niri.nixosModules.niri
  ];
}
