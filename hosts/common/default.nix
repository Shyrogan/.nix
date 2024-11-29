{ inputs, pkgs, ... }: let
  inherit (inputs) agenix;
in {
  imports = [
    ./nix.nix
    ./desktops/hyprland.nix
  ];

  time.timeZone = "Europe/Paris";

  # Some of those packages are kinda required for Nix to work properly.
  environment.systemPackages = with pkgs; [ git agenix.packages.${pkgs.system}.default ];

  system.stateVersion = "24.11";
}
