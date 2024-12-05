{ config, lib, ... }: with lib; let
  cfg = config.programs.zellij;
in {
  config.programs.zellij = mkIf cfg.enable {
    settings = {
    };
  };
}
