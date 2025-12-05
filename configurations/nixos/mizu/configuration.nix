{
  flake,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  hardware = {
    amdgpu = {
      opencl.enable = true;
    };
    bluetooth.enable = true;
    wooting.enable = true;
  };
  powerManagement.enable = true;
  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxKernel.packagesFor pkgs.linuxKernel.kernels.linux_zen;
    kernelParams = ["usbcore.autosuspend=-1"];
  };

  networking = {
    hostName = "mizu";
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };
  console.keyMap = "fr";

  powerManagement.powertop.enable = true;
  services = {
    printing.enable = true;
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    displayManager.autoLogin = {
      enable = true;
      user = "sebastien";
    };
    openssh.enable = true;
    usbmuxd.enable = true;
    upower.enable = true;
    power-profiles-daemon.enable = true;
    gvfs.enable = true;
  };
  security.rtkit.enable = true;

  users.users.sebastien = {
    isNormalUser = true;
    description = "sebastien";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "fuse"
    ];
    shell = pkgs.nushell;
  };
  programs = {
    git.enable = true;
    steam.enable = true;
    hyprland.enable = true;
    fuse = {
      enable = true;
      userAllowOther = true;
    };
  };
  environment.systemPackages = [
    pkgs.ifuse
    pkgs.overskride
  ];
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  # This is disabled due to it blocking boot
  systemd.services = {
    NetworkManager-wait-online.enable = false;
  };

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";
}
