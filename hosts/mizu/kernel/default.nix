{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxKernel.packagesFor pkgs.linuxKernel.kernels.linux_latest;
    # kernelParams = ["amdgpu.dcdebugmask=0x12"];
    # kernelPatches = [
    #   {
    #     name = "[PATCH] drm/amd: Mark displays as fake enabled";
    #     patch = ./0001-drm-amd-Mark-displays-as-fake-enabled-in-S4.patch;
    #   }
    # ];
  };
}
