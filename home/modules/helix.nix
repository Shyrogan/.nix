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
    package = pkgs.evil-helix;
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
        {
          name = "python";
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
    packages = with pkgs; [ nil ];
  };
}
