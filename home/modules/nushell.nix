{ config, lib, ... }: with lib; let
  cfg = config.programs.nushell;
in {
  # Enabling Nushell will also enable Carapace
  programs = mkIf cfg.enable {
    nushell = {
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
    # Yeah fuck
    thefuck = {
      enable = true;
      enableNushellIntegration = true;
    };
    # Yazi
    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };
    # For help
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    # and also Starship !!
    starship = {
      enable = true;
      enableNushellIntegration = true;
    };
    # finally zoxide
    zoxide = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
