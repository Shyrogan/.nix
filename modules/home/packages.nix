{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ripgrep
    fd
    sd
    tree

    # Nix dev
    cachix
    nil
    nix-info
    nixpkgs-fmt
  ];

  programs = {
    # Better `cat`
    bat.enable = true;
    # Type `<ctrl> + r` to fuzzy search your shell history
    fzf.enable = true;
    jq.enable = true;
    # Install btop https://github.com/aristocratos/btop
    btop.enable = true;
  };
}
