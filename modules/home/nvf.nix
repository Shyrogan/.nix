{ config, flake, lib, ... }: 
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

      languages = {
      	enableDAP = true;
	enableExtraDiagnostics = true;
	enableTreesitter = true;

	nix.enable = true;
      };

      lsp = {
        enable = true;
        lspkind.enable = true;
        lspsaga.enable = true;
        trouble.enable = true;
      };
    };
  };
}
