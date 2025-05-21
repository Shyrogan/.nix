{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.programs.helix;
in {
  programs.helix = mkIf cfg.enable {
    defaultEditor = true;
    languages = {
      language = [
        {
          name = "rust";
        }
        {
          name = "nix";
        }
        {
          name = "typst";
        }
        {
          name = "javascript";
        }
        {
          name = "typescript";
        }
      ];
    };
    settings = {
      editor = {
        line-number = "relative";
        lsp.display-messages = true;
      };
    };
  };
  home = mkIf cfg.enable {
    packages = with pkgs; [ nil ruff typescript-language-server ];
  };
}
