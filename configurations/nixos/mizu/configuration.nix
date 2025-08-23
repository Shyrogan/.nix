{ pkgs, ... }:
{
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  console.keyMap = "fr";

  hardware = {
    amdgpu = {
      opencl.enable = true;
    };
    bluetooth.enable = true;
  };

  networking = {
    hostName = "mizu";
    networkmanager.enable = true;
  };

  users = {
    mutableUsers = true;
    users = {
      sebastien = {
        isNormalUser = true;
        extraGroups = ["wheel" "audio" "docker" "dialout"];
        password = "hello";
        packages = with pkgs; [
          # Default shell
          nushell
        ];
        shell = pkgs.nushell;
      };
    };
  };

  # This is disabled due to it blocking boot
  systemd.services = {
    NetworkManager-wait-online.enable = false;
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
}
