{
  config,
  lib,
  ...
}: let
  inherit (config.programs) nvf;
  inherit (config.lib.stylix) colors;
  theme_provider = import ./theme.nix;
in {
  programs.nvf.settings.vim = lib.mkIf nvf.enable {
    imports = [
      ./oil.nix
    ];
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
    };
    formatter.conform-nvim.enable = true;

    telescope.enable = true;
    ui = {
      breadcrumbs = {
        enable = true;
        lualine.winbar.enable = true;
      };
      noice.enable = true;
    };
    statusline.lualine = import ./lualine.nix;
    binds.whichKey = {
      enable = true;
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
  };
}
