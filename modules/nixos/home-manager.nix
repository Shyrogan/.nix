{ flake, ...}: 
let
  inherit (flake) inputs;
  inherit (inputs) home-manager;
in
{
  environment.systemPackages = [
    home-manager.packages.default
  ];
}
