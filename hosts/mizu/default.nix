{pkgs, ...}: {
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./virtualisation.nix
    ./hardware.nix
    ./wifi.nix
    ./kernel
  ];

  age.identityPaths = ["/home/sebastien/.ssh/id_ed25519"];

  networking = {
    hostName = "mizu";
  };
  environment = {
    variables = {
      ROC_ENABLE_PRE_VEGA = "1";
    };
  };

  virtualisation.docker.enable = true;

  programs = {
    hyprland.enable = true;
    steam.enable = true;
  };

  services = {
    ollama = {
      enable = true;
      acceleration = "rocm";
      rocmOverrideGfx = "11.0.3";
    };
  };

  # Users for my laptop
  users = {
    mutableUsers = true;
    users = {
      sebastien = {
        isNormalUser = true;
        extraGroups = ["wheel" "audio" "docker" "dialout"];
        packages = with pkgs; [nushell];
        shell = pkgs.nushell;
      };
      root = {
        hashedPassword = "!";
      };
    };
  };
}
