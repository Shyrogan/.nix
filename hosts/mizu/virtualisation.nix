{ config, lib, ... }: with lib;
let
  cfg = config.virtualisation.docker;
in{
  config.virtualisation.docker = mkIf cfg.enable {
    rootless = {
      enable = true;
    };
  };
}
