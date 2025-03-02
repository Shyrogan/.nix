{ lib, inputs, pkgs, ... }: with lib;
let
  inherit (inputs) neve nixvim fenix;
in
{
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
    plugins = {
      copilot-vim.enable = lib.mkForce false;
      copilot-chat.enable = lib.mkForce false;
      copilot-cmp.enable = lib.mkForce false;

      tailwind-tools.enable = true;

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
        rust_analyzer = let f = fenix.packages.${pkgs.system}; in {
          package = f.rust-analyzer;
          cargoPackage = f.stable.cargo;
          rustcPackage = f.stable.rustc;
          rustfmtPackage = f.stable.rustfmt;
        };
        tinymist.enable = true;
        svelte.enable = true;
        tailwindcss.enable = true;
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
      avante.enable = true;
      wakatime.enable = lib.mkForce false;
      nvim-jdtls = {
        enable = lib.mkForce true;
        jdtLanguageServerPackage = pkgs.jdt-language-server;
      };
    };
    copilot.enable = false;
    cloak.enable = false;
    nvterm.enable = false;
    ultimate-autopair.enable = false;
  };
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
