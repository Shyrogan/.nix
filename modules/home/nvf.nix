{
  flake,
  pkgs,
  ...
}: let
  inherit (flake.inputs) nvf;
  inherit (nvf.lib.nvim.dag) entryAfter;
in {
  imports = [
    nvf.homeManagerModules.default
  ];

  programs.nvf = {
    settings.vim = {
      enableLuaLoader = true;
      clipboard.enable = true;
      undoFile.enable = true;

      binds.whichKey.enable = true;

      treesitter = {
        enable = true;
        fold = true;
        autotagHtml = true;
        indent.enable = true;

        grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          typescript
        ];
      };
      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableFormat = true;
        enableTreesitter = true;

        nix.enable = true;
        ts = {
          enable = true;
          format.type = "prettierd";
          extensions.ts-error-translator.enable = true;
        };
        python.enable = true;
        css.enable = true;
        html.enable = true;
        tailwind.enable = true;
        helm.enable = true;
        qml.enable = true;
      };
      telescope = {
        enable = true;
        extensions = [
          {
            name = "fzf";
            packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
            setup = {
              fzf = {
                fuzzy = true;
              };
            };
          }
        ];
      };
      lsp = {
        enable = true;
        lspkind.enable = true;
        lspsaga.enable = true;
        trouble.enable = true;
      };
      navigation.harpoon = {
        enable = true;
        mappings = {
          file1 = "&";
          file2 = "é";
          file3 = ''"'';
          file4 = "'";
        };
      };
      autocomplete.blink-cmp.enable = true;
      formatter.conform-nvim = {
        enable = true;
        setupOpts.format_on_save = {
          timeout_ms = 500;
          lsp_format = "fallback";
        };
      };
      assistant.avante-nvim = {
        enable = true;
        setupOpts = {
          providers = {
            openrouter = {
              __inherited_from = "openai";
              endpoint = "https://openrouter.ai/api/v1";
              api_key_name = "OPENROUTER_API_KEY";
              model = "x-ai/grok-code-fast-1";
              timeout = 30000;
            };
            openrouter_claude = {
              __inherited_from = "openai";
              endpoint = "https://openrouter.ai/api/v1";
              api_key_name = "OPENROUTER_API_KEY";
              model = "anthropic/claude-sonnet-4.5";
              timeout = 30000;
            };
          };
        };
      };
      ui = {
        noice.enable = true;
        borders.enable = true;
        fastaction.enable = true;
        illuminate.enable = true;
        colorizer.enable = true;
        colorizer.setupOpts.filetypes = {
          "*" = {};
        };
      };
      lazy = {
        enable = true;
        plugins = {
          # "fff.nvim" = {
          #   enabled = true;
          #   package = fff.packages.${pkgs.system}.fff-nvim;
          # };
        };
      };
      keymaps = [
        # {
        #   key = "<leader>ff";
        #   mode = "n";
        #   silent = true;
        #   action = "<cmd>FFFFind<cr>";
        # }
        {
          key = "<leader>o";
          mode = "n";
          silent = true;
          action = "<cmd>Oil<cr>";
        }
        {
          key = "<C-s>";
          action = "<cmd>w<cr>";
          mode = [
            "n"
            "v"
            "x"
          ];
          desc = "Save buffer";
        }
        {
          key = "<C-j>";
          action = "<cmd>wincmd j<cr>";
          mode = [
            "n"
            "v"
            "x"
          ];
          desc = "Move to pane below";
        }
        {
          key = "<C-k>";
          action = "<cmd>wincmd k<cr>";
          mode = [
            "n"
            "v"
            "x"
          ];
          desc = "Move to pane above";
        }
        {
          key = "<C-l>";
          action = "<cmd>wincmd l<cr>";
          mode = [
            "n"
            "v"
            "x"
          ];
          desc = "Move to pane to the right";
        }
        {
          key = "<C-h>";
          action = "<cmd>wincmd h<cr>";
          mode = [
            "n"
            "v"
            "x"
          ];
          desc = "Move to pane to the left";
        }
      ];
      utility = {
        snacks-nvim.enable = true;
        oil-nvim.enable = true;
      };
      visuals = {
        indent-blankline.enable = true;
        rainbow-delimiters.enable = true;
      };
      options = {
        # Set tabs to 2 spaces
        tabstop = 2;
        softtabstop = 2;
        showtabline = 0;
        laststatus = 0;
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
      };
      luaConfigRC.transparentTheme =
        entryAfter ["theme"]
        # lua
        ''
          vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
          vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
          vim.api.nvim_set_hl(0, "Comment", { bg = "none" })
          vim.api.nvim_set_hl(0, "Constant", { bg = "none" })
          vim.api.nvim_set_hl(0, "Special", { bg = "none" })
          vim.api.nvim_set_hl(0, "Identifier", { bg = "none" })
          vim.api.nvim_set_hl(0, "Statement", { bg = "none" })
          vim.api.nvim_set_hl(0, "PreProc", { bg = "none" })
          vim.api.nvim_set_hl(0, "Type", { bg = "none" })
          vim.api.nvim_set_hl(0, "Underlined", { bg = "none" })
          vim.api.nvim_set_hl(0, "Todo", { bg = "none" })
          vim.api.nvim_set_hl(0, "String", { bg = "none" })
          vim.api.nvim_set_hl(0, "Function", { bg = "none" })
          vim.api.nvim_set_hl(0, "Conditional", { bg = "none" })
          vim.api.nvim_set_hl(0, "Repeat", { bg = "none" })
          vim.api.nvim_set_hl(0, "Operator", { bg = "none" })
          vim.api.nvim_set_hl(0, "Structure", { bg = "none" })
          vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
          vim.api.nvim_set_hl(0, "NonText", { bg = "none" })
          vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
          vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
          vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
          vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
          vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
          vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
        '';
    };
  };

  stylix.targets.nvf.transparentBackground = true;
  home.packages = [pkgs.typescript-language-server];
}
