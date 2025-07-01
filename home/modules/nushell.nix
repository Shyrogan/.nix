{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.nushell;
in {
  age.secrets.env.file = ../../secrets/env.age;
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
        "lg" = "lazygit";
      };
      envFile.text = ''
        source ${config.age.secrets.env.path}
      '';
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
    # Nix your shell
    nix-your-shell = {
      enable = true;
      enableNushellIntegration = true;
    };

    # Direnv
    direnv = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
