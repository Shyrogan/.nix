{ lib, inputs, ... }: with lib;
let
  inherit (inputs) neve nixvim;
in {
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    imports = [ neve.nixvimModule ];
    colorschemes = {
      base16 = {
        enable = mkForce true;
        colorscheme = "irblack";
      };
    };
    extraConfigLuaPost = ''
      vim.cmd [[colorscheme base16-irblack]]
    '';
    plugins.copilot-lua.enable = mkForce false;
  };
}
