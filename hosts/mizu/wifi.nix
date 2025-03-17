{
  config,
  pkgs,
  ...
}: {
  age.secrets.wifi.file = ../../secrets/wifi.age;

  networking = {
    networkmanager = {
      enable = true;
      #wifi.backend = "iwd";
    };
    # wireless.iwd.settings = {
    #   IPv6 = {
    #     Enabled = true;
    #   };
    #   Settings = {
    #     AutoConnect = true;
    #   };
    # };
  };
  # environment.systemPackages = [pkgs.iwdgui];
  # networking.wireless = {
  #   enable = true;
  #   secretsFile = config.age.secrets.wifi.path;
  #   networks = {
  #     "Freebox-maison" = {
  #       pskRaw = "ext:PSK_FREEBOX_MAISON";
  #     };
  #     "shreb" = {
  #       pskRaw = "ext:PSK_SHREB";
  #     };
  #   };
  #   userControlled.enable = true;
  # };
}
