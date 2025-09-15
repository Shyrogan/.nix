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
  programs.ghostty = mkIf cfg.enable {
    settings = {
      confirm-close-surface = false;
      font-style = "Medium";

      window-decoration = false;
      window-padding-x = 8;
      window-padding-y = 12;

      background-opacity = 0.85;
    };
  };
}
