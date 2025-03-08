{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (config.programs) nvf;
  inherit (config.lib.stylix) colors;
  theme_provider = import ./theme.nix;
in {
  programs.nvf = lib.mkIf nvf.enable {
    enableManpages = true;
    settings.vim = {
      enableLuaLoader = true;
      theme = theme_provider.withColors colors;
      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableLSP = true;
        enableTreesitter = true;

        nix.enable = true;
        rust.enable = true;
        # Web
        css.enable = true;
        html.enable = true;
        ts.enable = true;
        svelte.enable = true;
        tailwind.enable = true;
        # Work
        python.enable = true;
      };
      formatter.conform-nvim.enable = true;
      autocomplete.blink-cmp.enable = true;

      dashboard.startify.enable = true;
      telescope.enable = true;
      ui = import ./ui.nix;
      statusline.lualine = import ./lualine.nix;
      tabline.nvimBufferline.enable = true;
      binds.whichKey = {
        enable = true;
      };

      visuals = {
        nvim-web-devicons.enable = true;

        fidget-nvim.enable = true;
        highlight-undo.enable = true;
      };
      keymaps = [
        {
          key = "<C-s>";
          action = "<cmd>w<cr>";
          mode = ["n" "v" "x"];
          desc = "Save buffer";
        }
        {
          key = "<leader>bd";
          action = "<cmd>w!|bdelete!<cr>";
          mode = ["n" "v" "x"];
          desc = "Delete current buffer";
        }
      ];
      lazy.plugins = {
        "avante.nvim" = import ./plugins/avante.nix pkgs;
        "oil.nvim" = import ./plugins/oil.nix pkgs;
      };
    };
  };
}
