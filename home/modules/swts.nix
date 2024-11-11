{ inputs, config, lib, pkgs, ... }: with lib;
let
  inherit (inputs) swts;
  cfg = config.programs.swts;
in {
  options.programs.swts = {
    desktop.enable = mkEnableOption "Enable swts desktop bar";
  };

  config.home.packages = optionals cfg.desktop.enable [
    swts.packages.${pkgs.system}.swts-desktop
  ];
}
