{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.programs.lazygit;
in {
  programs.lazygit = mkIf cfg.enable {
    settings = {
      customCommands = [
        {
          key = "W";
          command = "git commit --no-verify";
          subprocess = true;
        }
      ];
    };
  };
}
