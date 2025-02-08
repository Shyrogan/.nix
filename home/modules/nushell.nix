{ config, lib, pkgs, ... }: with lib; let
  cfg = config.programs.nushell;
in {
  # Enabling Nushell will also enable Carapace
  config.programs = mkIf cfg.enable {
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
        "nd" = "nix develop --no-pure-eval";
      };
      envFile.text = ''
        $env.EDITOR = "nvim"
      '';
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
    # Nix your shell
    nix-your-shell = {
      enable = true;
      enableNushellIntegration = true;
    };
  };
}
