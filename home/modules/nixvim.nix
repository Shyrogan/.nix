{ lib, inputs, pkgs, ... }: with lib;
let
  inherit (inputs) neve nixvim; in {
  imports = [
    nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    imports = [ neve.nixvimModule ];
    colorschemes = {
      catppuccin.enable = mkForce false;
      gruvbox = {
        enable = true;
        settings = {
          terminal_colors = true;
          transparent_mode = true;
        };
      };
    };
    extraConfigLuaPost = ''vim.cmd [[ colorscheme gruvbox ]]'';
    plugins = {
      copilot-vim.enable = lib.mkForce false;
      copilot-chat.enable = lib.mkForce false;
      copilot-cmp.enable = lib.mkForce false;

      lsp.servers = {
        helm_ls.enable = true;
        dockerls.enable = true;
        sqls = {
          enable = true;
          onAttach.function = ''
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          '';
        };
        biome.enable = true;
        rust_analyzer = {
          rustcPackage = pkgs.rustc;
          rustfmtPackage = pkgs.rustfmt;
          cargoPackage = pkgs.cargo;
        };
        tinymist.enable = true;
      };
      typst-vim = {
        enable = true;
        settings = {
          pdf_viewer = "zathura";
        };
        keymaps = {
          watch = "<leader>dT";
        };
      };
    };
    copilot.enable = false;
    cloak.enable = false;
    nvterm.enable = false;
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
