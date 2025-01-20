{ inputs, config, lib, ... }: with lib; let
  cfg = config.programs.ghostty;
in {
  #options.programs.ghostty.enable = mkEnableOption "Enable Ghostty terminal";

  #config.home.packages = optionals cfg.enable [ ghostty.packages.x86_64-linux.default  ];
  #config.xdg.configFile."ghostty/config" = mkIf cfg.enable {
  #  text = builtins.readFile ../../assets/config/ghostty;
  #};
  programs.ghostty = mkIf cfg.enable {
    settings = {
      theme = "GruvboxDarkHard";
      confirm-close-surface = false;
      font-family = "JetBrainsMono Nerd Font";
      font-style = "Medium";

      window-decoration = false;
      window-padding-x = 8;
      window-padding-y = 12;
    };
  };
}
