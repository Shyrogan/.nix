{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.programs.ghostty;
in
{
  home.file = mkIf cfg.enable {
    "./.config/ghostty/config".text = ''
      confirm-close-surface = false
      cursor-style = bar
      mouse-hide-while-typing = true

      window-decoration = false;
      window-padding-x = 8;
      window-padding-y = 12;

      
      background-opacity = 0.8

    '';
  };

}
