{ pkgs, ... }: {
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./virtualisation.nix
    ./hardware.nix
    ./kernel.nix
  ];

  networking.hostName = "mizu";
  #networking.networkmanager.enable = true;

  programs.hyprland.enable = true;

  virtualisation.docker.enable = true;

  # Users for my laptop
  users = {
    mutableUsers = true;
    users = {
      sebastien = {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "docker" "dialout" ];
        packages = with pkgs; [ nushell ];
        shell = pkgs.nushell;
      };
      root = {
        hashedPassword = "!";
      };
    };
  };
}
