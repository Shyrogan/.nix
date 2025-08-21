{ flake, ... }: 
let
  inherit (flake) inputs;
  inherit (inputs) niri;
in
{
  imports = [
    niri.homeModules.niri
  ];
}
