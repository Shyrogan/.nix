{ config, lib, ... }: with lib; let
  cfg = config.services.k3s;
in {
  config.networking.firewall = mkIf cfg.enable {
    allowedTCPPorts = [ 6443 ];
  };
  config.services.k3s = mkIf cfg.enable {
    role = "server";
  };
}
