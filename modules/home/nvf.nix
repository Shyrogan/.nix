{ flake, ... }:
let
  inherit (flake.inputs) nvf;
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
      ui = {
        noice.enable = true;
        borders.enable = true;
        fastaction.enable = true;
        illuminate.enable = true;
        colorizer.enable = true;
      };
    };
  };
}
