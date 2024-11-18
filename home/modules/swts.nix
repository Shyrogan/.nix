{ inputs, config, lib, pkgs, ... }: with lib;
let
  inherit (inputs) swts;
  cfg = config.programs.swts;
in {
  options.programs.swts = {
    bar.enable = mkEnableOption "Enable swts desktop bar";
  };

  config.home.packages = optionals cfg.bar.enable [
    swts.packages.${pkgs.system}.bar
  ];
}
