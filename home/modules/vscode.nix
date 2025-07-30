{ config, lib, ... }: with lib; let
  cfg = config.programs.vscode;
in {
  programs.vscode = mkIf cfg.enable {
  };
}
