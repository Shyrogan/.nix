{ pkgs, ... }: {
  imports = [
    ./nix.nix
    ./desktops/hyprland.nix
  ];

  time.timeZone = "Europe/Paris";

  # Some of those packages are kinda required for Nix to work properly.
  environment.systemPackages = with pkgs; [ git ];

  system.stateVersion = "24.11";
}
