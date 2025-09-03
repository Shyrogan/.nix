{ flake, ... }:
let
  inherit (flake.inputs) spicetify-nix;
in 
{
  imports = [
    spicetify-nix.homeManagerModules.spicetify 
  ];
}
