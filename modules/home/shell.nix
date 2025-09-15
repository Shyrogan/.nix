{ config, lib, ... }:
{
  age.secrets.env.file = ../../assets/secrets/sebastien.age;
  programs =
    let
      enabled = lib.mkIf config.programs.nushell.enable;
    in
    {
      nushell = {
        shellAliases = {
          "cat" = "bat";
        };
        settings = {
          show_banner = false;
        };
        envFile.text = ''
          source ${config.age.secrets.env.path}
        '';
      };

      bat.enable = enabled;

      carapace.enable = enabled;
      carapace.enableNushellIntegration = enabled;

      eza.enable = enabled;
      eza.enableNushellIntegration = enabled;

      nix-your-shell.enable = enabled;
      nix-your-shell.enableNushellIntegration = enabled;

      pay-respects.enable = enabled;
      pay-respects.enableNushellIntegration = enabled;

      starship.enable = enabled;
      starship.enableNushellIntegration = enabled;

      zoxide.enable = enabled;
      zoxide.enableNushellIntegration = enabled;
    };
}
