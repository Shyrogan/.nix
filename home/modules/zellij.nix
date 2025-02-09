{ config, lib, ... }: with lib; let
  cfg = config.programs.zellij;
in {
  options.programs.zellij.nuShellIntegration = mkEnableOption "Enable zellij for nu";
  config.xdg.configFile."zellij/config.kdl" = mkIf cfg.enable {
    text = builtins.readFile ../../assets/config/zellij.kdl;
  };
  config.programs.nushell = mkIf cfg.nuShellIntegration {
    extraConfig = ''
      def start_zellij [] {
        if 'ZELLIJ' not-in ($env | columns) {
          if 'ZELLIJ_AUTO_ATTACH' in ($env | columns) and $env.ZELLIJ_AUTO_ATTACH == 'true' {
            zellij attach -c
          } else {
            zellij
          }

          if 'ZELLIJ_AUTO_EXIT' in ($env | columns) and $env.ZELLIJ_AUTO_EXIT == 'true' {
            exit
          }
        }
      }

      start_zellij
    '';
  };
}
