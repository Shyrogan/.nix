{ pkgs, ... }: {
  imports = [
    ./nix.nix
    ./wifi.nix
  ];

  # Some of those packages are kinda required for Nix to work properly.
  environment.systemPackages = with pkgs; [ git ];

  system.stateVersion = "24.11";
}
