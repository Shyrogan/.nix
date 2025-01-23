{ config, lib, ... }: with lib; let
  cfg = config.programs.steam;
in {
  config.programs = mkIf cfg.enable {
    steam = {
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    gamemode.enable = true;
  };
}
