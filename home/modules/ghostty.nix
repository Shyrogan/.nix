{ inputs, config, lib, ... }: with lib; let
  cfg = config.programs.ghostty;
  inherit (inputs) ghostty;
in {
  options.programs.ghostty.enable = mkEnableOption "Enable Ghostty terminal";

  config.home.packages = optionals cfg.enable [ ghostty.packages.x86_64-linux.default  ];
  config.xdg.configFile."ghostty/config" = mkIf cfg.enable {
    text = builtins.readFile ../../assets/config/ghostty;
  };
}
