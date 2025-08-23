{ config, lib, ... }: {
  programs.ghostty = lib.mkIf config.programs.ghostty.enable {
    installVimSyntax = true;
  };
}
