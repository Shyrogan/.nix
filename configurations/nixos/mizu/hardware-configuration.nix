{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" "sdhci_pci" ];
      kernelModules = [ ];
    };
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/14d19016-9411-49ee-b4ca-1cd1c189ddb7";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BDDD-2F68";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
  };
  
  swapDevices = [
    { device = "/dev/disk/by-uuid/bed2c0ec-2c56-4f7f-9f35-c0daba6469a0"; }
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}

