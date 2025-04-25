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
    firewall = {
      enable = true;
      allowedTCPPortRanges = [
        {
          from = 30000;
          to = 60000;
        }
      ];
      allowedUDPPortRanges = [
        {
          from = 30000;
          to = 60000;
        }
      ];
    };
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
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        workstation = true;
        userServices = true;
      };
    };
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

          # UxPlay needs to be installed on Host
          uxplay
        ];
        shell = pkgs.nushell;
      };
      root = {
        hashedPassword = "!";
      };
    };
  };
}
