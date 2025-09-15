{ flake, pkgs, ... }:
let
  inherit (flake.inputs) nvf fff;
  inherit (nvf.lib.nvim.dag) entryAfter;
in
{
  imports = [
    nvf.homeManagerModules.default
  ];

  programs.nvf = {
    settings.vim = {
      enableLuaLoader = true;
      clipboard.enable = true;
      undoFile.enable = true;

      binds.whichKey.enable = true;

      languages = {
        enableDAP = true;
        enableExtraDiagnostics = true;
        enableTreesitter = true;

        nix.enable = true;
      };
      lsp = {
        enable = true;
        lspsaga.enable = true;
        trouble.enable = true;
      };
      autocomplete.blink-cmp.enable = true;
      formatter.conform-nvim.enable = true;
      assistant.avante-nvim = {
        enable = true;
        setupOpts = {
          providers.openrouter = {
            __inherited_from = "openai";
            endpoint = "https://openrouter.ai/api/v1";
            api_key_name = "OPENROUTER_API_KEY";
            model = "x-ai/grok-code-fast-1";
            timeout = 30000; 
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
          "*" = { };
        };
      };
      lazy = {
        enable = true;
        plugins = {
          "fff.nvim" = {
            enabled = true;
            package = fff.packages.${pkgs.system}.fff-nvim;
          };
        };
      };
      keymaps = [
        {
          key = "<leader>ff";
          mode = "n";
          silent = true;
          action = "<cmd>FFFFind<cr>";
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
        cmdheight = 0;
        autochdir = true;
        autoindent = true;
        backup = false;
        fileencoding = "utf-8";
        history = 50;
        hlsearch = true;
        ignorecase = true;
        numberwidth = 4;
        pumheight = 10;
        shiftwidth = 4;
        scrolloff = 8;
        showmode = false;
        sidescrolloff = 8;
        smartcase = true;
        smartindent = true;
        splitbelow = true;
        splitright = true;
        tabstop = 4;
        timeoutlen = 500;
        wrap = false;
      };
      luaConfigRC.transparentTheme =
        entryAfter [ "theme" ]
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
}
