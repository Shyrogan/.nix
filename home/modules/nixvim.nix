{ lib, inputs, ... }: with lib;
let
  inherit (inputs) neve nixvim;
in {
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    imports = [ neve.nixvimModule ];
    colorschemes = {
      base16 = {
        enable = mkForce true;
        colorscheme = "summerfruit-dark";
      };
    };
    extraConfigLuaPost = ''
      vim.cmd [[colorscheme base16-summerfruit-dark]]
    '';
    plugins = {
      copilot-vim.enable = lib.mkForce false;
      copilot-chat.enable = lib.mkForce false;
      copilot-cmp.enable = lib.mkForce false;

      lsp.servers = {
        helm_ls.enable = true;
        dockerls.enable = true;
        dartls.enable = true;
      };
    };
    copilot.enable = false;
    cloak.enable = false;
    nvterm.enable = false;
  };
}
