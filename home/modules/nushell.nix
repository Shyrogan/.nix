{ config, lib, ... }: with lib; let
  cfg = config.programs.nushell;
in {
  programs.nushell = mkIf cfg.enable {
    configFile = {
      text = ''
        $env.config = {
          show_banner: false,
        }
      '';
    };
    shellAliases = {
      "ll" = "ls -l";
      "lla" = "ls -la";
    };
  };
  # Enabling Nushell will also enable Carapace
  programs.carapace = mkIf cfg.enable {
    enable = true;
    enableNushellIntegration = true;
  };
  # and also Starship !!
  programs.starship = mkIf cfg.enable {
    enable = true;
    enableNushellIntegration = true;
  };
  # finally zoxide
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = true;
  };
}
