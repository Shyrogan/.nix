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

  programs = {
    hyprland.enable = true;
    steam.enable = true;
  };

  # Users for my laptop
  users = {
    mutableUsers = true;
    users = {
      sebastien = {
        isNormalUser = true;
        extraGroups = ["wheel" "audio" "docker" "dialout"];
        packages = with pkgs; [
          # Default shell
          nushell

          # GPU rocm
          pkgs.rocmPackages.rpp
          pkgs.rocmPackages.clr
          pkgs.rocmPackages.hipcc
          pkgs.rocmPackages.rocm-smi
        ];
        shell = pkgs.nushell;
      };
      root = {
        hashedPassword = "!";
      };
    };
  };
}
