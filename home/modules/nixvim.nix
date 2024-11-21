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
        colorscheme = "gruvbox-dark-medium";
      };
    };
    extraConfigLuaPost = ''
      vim.cmd [[colorscheme base16-gruvbox-dark-medium]]
    '';
    plugins = {
      copilot-lua.enable = mkForce false;
      typst-vim = {
        enable = true;
        settings = {
          pdf_viewer = "zathura";
        };
        keymaps = {
          watch = "<leader>ctw";
        };
      };
      cloak.enable = lib.mkForce false;
      lsp.servers.typst_lsp.enable = true;
    };
  };
}
