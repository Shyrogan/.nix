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
      clipboard.enable = true;
      undoFile.enable = true;
      theme = theme_provider.withColors colors;
      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;

        nix.enable = true;
        rust = {
          enable = true;
          crates = {
            enable = true;
            codeActions = true;
          };
          lsp = {
            enable = true;
            opts = ''
              ['rust-analyzer'] = {
                cargo = { allFeatures = true },
                checkOnSave = true,
                check = {
                  enable = true,
                  command = 'clippy',
                  features = 'all',
                },
                procMacro = {
                  enable = true,
                },
              },
            '';
          };
        };
        # Web
        css.enable = true;
        html.enable = true;
        svelte.enable = true;
        tailwind.enable = true;
        ts.enable = true;
        # Work
        python.enable = true;
        python.format.type = "ruff";
        # DevOps
        helm.enable = true;

        typst = {
          enable = true;
          extensions.typst-preview-nvim = {
            enable = true;
            setupOpts = {
              open_cmd = "zen %s -P typst-preview --class typst-preview";
            };
          };
        };
      };
      formatter.conform-nvim.enable = true;
      autocomplete.blink-cmp.enable = true;
      comments.comment-nvim.enable = true;
      lsp = {
        enable = true;
        lspkind.enable = true;
        lspsaga.enable = true;
        trouble.enable = true;
      };

      telescope.enable = true;
      ui = import ./ui.nix;
      statusline.lualine = import ./lualine.nix;
      tabline.nvimBufferline = import ./plugins/bufferline.nix;
      git.gitsigns.enable = true;
      binds.whichKey = {
        enable = true;
      };

      visuals = {
        nvim-web-devicons.enable = true;
        indent-blankline.enable = true;
        fidget-nvim.enable = true;
        highlight-undo.enable = true;
      };
      keymaps = import ./keymaps.nix;
      lazy.plugins = {
        "avante.nvim" = import ./plugins/avante.nix pkgs;
        "oil.nvim" = import ./plugins/oil.nix pkgs;
        "mini.colors" = import ./plugins/mini-colors.nix pkgs;
        "claude-code.nvim" = import ./plugins/claude-code.nix;
      };
      navigation = {
        harpoon = import ./plugins/harpoon.nix;
      };
      options = import ./options.nix;
    };
  };
}
