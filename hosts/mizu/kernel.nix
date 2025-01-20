{ pkgs, ... }: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_6_11;
    kernelPatches = [
      {
        name = "v2-1-1-Bluetooth-btusb-add-13d3-3608-VID-PID-for-MT7925";
        patch = ./patches/v2-1-1-Bluetooth-btusb-add-13d3-3608-VID-PID-for-MT7925.patch;
      }
    ];
    kernelParams = ["amdgpu.dcdebugmask=0x600"];
  };
}
