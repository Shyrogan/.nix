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
        #colorscheme = "tokyonight";
      };
    };
    #extraConfigLuaPost = ''
    #  vim.cmd [[colorscheme base16-tokyonight]]
    #'';
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
      lsp.servers.typst_lsp.enable = true;
    };
  };
}
