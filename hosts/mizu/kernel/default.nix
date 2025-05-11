{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxKernel.packagesFor pkgs.linuxKernel.kernels.linux_testing;
    kernelParams = ["amdgpu.dcdebugmask=0x12"];
    # kernelPatches = [
    #   {
    #     name = "v5-1-6-Revert-wifi-mt76-mt7925-Update-mt7925_mcu_uni_-tx-rx-_ba-for-MLO";
    #     patch = ./v5-1-6-Revert-wifi-mt76-mt7925-Update-mt7925_mcu_uni_-tx-rx-_ba-for-MLO.patch;
    #   }
    # ];
    kernelPatches = [
      {
        name = "[PATCH] drm/amd: Revert patch that causes hang in S4";
        patch = ./0001-Possible-fix-by-Mario-to-add-amdgpu_dm_hpd_fini-befo.patch;
      }
    ];
  };
}
