{ pkgs, ... }: {
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./virtualisation.nix
    ./hardware.nix
    ./kernel.nix
  ];

  networking = {
    hostName = "mizu";
    networkmanager.enable = true;
  };
  environment = {
    variables = {
      ROC_ENABLE_PRE_VEGA = "1";
    };
    systemPackages = with pkgs; [ networkmanagerapplet ];
  };

  virtualisation.docker.enable = true;

  programs = {
    hyprland.enable = true;
    steam.enable = true;
  };

  hardware = {
    amdgpu.opencl.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages_5.clr}"
  ];

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
