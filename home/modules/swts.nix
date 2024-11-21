{ inputs, config, lib, pkgs, ... }: with lib;
let
  inherit (inputs) swts;
  cfg = config.programs.swts;
in {
  options.programs.swts = {
    bar = {
      enable = mkEnableOption "Enable swts desktop bar";
      hyprland.enable = mkEnableOption "Enable swts desktop bar on hyprland startup";
    };
  };

  config = {
    wayland.windowManager.hyprland.settings = mkIf cfg.bar.hyprland.enable {
      exec-once = [
        "swts-bar"
      ];
    };
    home.packages = optionals cfg.bar.enable [
      swts.packages.${pkgs.system}.bar
    ];
  };
}
