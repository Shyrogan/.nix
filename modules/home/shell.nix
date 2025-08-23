{ config, lib, ... }:
{
  config.programs = lib.mkIf config.programs.nushell.enable {
    nushell = {
      shellAliases = {
        "cat" = "bat";
      };
    };

    bat.enable = true;
    
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    eza.enable = true;
    eza.enableNushellIntegration = true;

    nix-your-shell.enable = true;
    nix-your-shell.enableNushellIntegration = true;

    pay-respects.enable = true;
    pay-respects.enableNushellIntegration = true;

    starship.enable = true;
    starship.enableNushellIntegration = true;

    zoxide.enable = true;
    zoxide.enableNushellIntegration = true;
  };
}
