{ pkgs, ...}: 
{
  environment.systemPackages = [
    pkgs.home-manager
    pkgs.nh
  ];
}
