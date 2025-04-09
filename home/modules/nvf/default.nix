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
      useSystemClipboard = true;
      undoFile.enable = true;
      theme = theme_provider.withColors colors;
      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableLSP = true;
        enableTreesitter = true;

        nix.enable = true;
        rust = {
          enable = true;
          crates = {
            enable = true;
            codeActions = true;
          };
          lsp.opts = ''
            ['rust-analyzer'] = {
              cargo = {allFeature = true},
              checkOnSave = true,
              procMacro = {
                enable = true,
              },
            },
          '';
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

      dashboard.startify.enable = true;
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
      keymaps = [
        {
          key = "<C-s>";
          action = "<cmd>w<cr>";
          mode = ["n" "v" "x"];
          desc = "Save buffer";
        }
        {
          key = "<C-j>";
          action = "<cmd>wincmd j<cr>";
          mode = ["n" "v" "x"];
          desc = "Move to pane below";
        }
        {
          key = "<C-k>";
          action = "<cmd>wincmd k<cr>";
          mode = ["n" "v" "x"];
          desc = "Move to pane above";
        }
        {
          key = "<C-l>";
          action = "<cmd>wincmd l<cr>";
          mode = ["n" "v" "x"];
          desc = "Move to pane to the right";
        }
        {
          key = "<C-h>";
          action = "<cmd>wincmd h<cr>";
          mode = ["n" "v" "x"];
          desc = "Move to pane to the left";
        }
      ];
      lazy.plugins = {
        "avante.nvim" = import ./plugins/avante.nix pkgs;
        "oil.nvim" = import ./plugins/oil.nix pkgs;
      };
      options = {
        # Set tabs to 2 spaces
        tabstop = 2;
        softtabstop = 2;
        showtabline = 2;
        expandtab = true;

        # Enable auto indenting and set it to spaces
        smartindent = true;
        shiftwidth = 2;

        # Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
        breakindent = true;

        # Enable incremental searching
        hlsearch = true;
        incsearch = true;

        # Enable ignorecase + smartcase for better searching
        ignorecase = true;
        smartcase = true; # Don't ignore case with capitals
        grepprg = "rg --vimgrep";
        grepformat = "%f:%l:%c:%m";

        # Decrease updatetime
        updatetime = 50; # faster completion (4000ms default)

        # Enable text wrap
        wrap = true;

        list = true; # Show invisible characters (tabs, eol, ...)
        listchars = "eol:↲,tab:··,lead:·,space: ,trail:•,extends:→,precedes:←,nbsp:␣";
      };
    };
  };
}
