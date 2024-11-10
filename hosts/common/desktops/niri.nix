{ inputs, pkgs, ... }: let
  inherit (inputs) niri;
in {
  imports = [niri.nixosModules.niri];
  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [ alacritty ];
  services.xserver = {
    enable = true;
    xkb = {
      layout = "fr";
    };
  };
}
