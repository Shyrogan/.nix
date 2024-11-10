{ pkgs, ... }: {
  imports = [
    ./hardware.nix
    ./kernel.nix
    ./audio.nix
  ];

  networking.hostName = "mizu";
  networking.networkmanager.enable = true;

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
