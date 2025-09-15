{ flake, ... }:
let
  inherit (flake.inputs) agenix;
in
{
  imports = [
    agenix.nixosModules.default
  ];
}
