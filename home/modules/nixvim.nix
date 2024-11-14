{ lib, config, inputs, ... }: with lib;
let
  inherit (inputs) neve nixvim;
  cfg = config.programs.nixvim;
in {
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = mkIf cfg.enable {
    imports = [ neve.nixvimModule ];
  };
}
